#!/usr/bin/env bash

# Webhook Setup Script for niri-flake
# This script helps set up repository_dispatch webhooks to monitor the niri repository

set -euo pipefail

# Configuration
NIRI_REPO="soulvice/niri"
DEFAULT_REPO_OWNER=""
DEFAULT_REPO_NAME="niri-flake"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    if ! command -v curl &> /dev/null; then
        log_error "curl is required but not installed"
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        log_error "jq is required but not installed"
        exit 1
    fi

    if ! command -v gh &> /dev/null; then
        log_warning "GitHub CLI (gh) is not installed - some features will be limited"
    fi

    log_success "Prerequisites check passed"
}

# Get repository information
get_repo_info() {
    echo
    log_info "Repository Configuration"
    echo "=========================="

    if [[ -n "${DEFAULT_REPO_OWNER}" ]]; then
        read -p "Repository owner [$DEFAULT_REPO_OWNER]: " REPO_OWNER
        REPO_OWNER=${REPO_OWNER:-$DEFAULT_REPO_OWNER}
    else
        read -p "Repository owner (GitHub username/org): " REPO_OWNER
    fi

    read -p "Repository name [$DEFAULT_REPO_NAME]: " REPO_NAME
    REPO_NAME=${REPO_NAME:-$DEFAULT_REPO_NAME}

    FULL_REPO="$REPO_OWNER/$REPO_NAME"

    log_info "Target repository: $FULL_REPO"

    # Verify repository exists
    if command -v gh &> /dev/null; then
        if gh repo view "$FULL_REPO" &> /dev/null; then
            log_success "Repository verified: $FULL_REPO"
        else
            log_warning "Could not verify repository access: $FULL_REPO"
        fi
    fi
}

# Get GitHub token
get_github_token() {
    echo
    log_info "GitHub Authentication"
    echo "====================="

    if command -v gh &> /dev/null && gh auth status &> /dev/null; then
        log_success "GitHub CLI is authenticated"
        read -p "Use GitHub CLI authentication? (y/n) [y]: " USE_GH_CLI
        USE_GH_CLI=${USE_GH_CLI:-y}

        if [[ "$USE_GH_CLI" =~ ^[Yy]$ ]]; then
            GITHUB_TOKEN=$(gh auth token)
            log_success "Using GitHub CLI token"
            return
        fi
    fi

    echo "You need a GitHub Personal Access Token with 'repo' scope."
    echo "Create one at: https://github.com/settings/tokens/new"
    echo
    read -s -p "GitHub Personal Access Token: " GITHUB_TOKEN
    echo

    if [[ -z "$GITHUB_TOKEN" ]]; then
        log_error "GitHub token is required"
        exit 1
    fi

    log_success "GitHub token configured"
}

# Test repository access
test_repo_access() {
    echo
    log_info "Testing repository access..."

    response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
                "https://api.github.com/repos/$FULL_REPO" || echo "")

    if echo "$response" | jq -e '.id' &> /dev/null; then
        log_success "Repository access confirmed"
        repo_name=$(echo "$response" | jq -r '.full_name')
        log_info "Repository: $repo_name"
    else
        log_error "Failed to access repository: $FULL_REPO"
        echo "Response: $response"
        exit 1
    fi
}

# Test repository_dispatch trigger
test_trigger() {
    echo
    log_info "Testing repository_dispatch trigger..."

    payload='{
        "event_type": "niri-update",
        "client_payload": {
            "ref": "refs/heads/main",
            "sha": "test-sha-123",
            "repository": "soulvice/niri",
            "commit_message": "Test webhook setup",
            "pusher": "webhook-setup-script",
            "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"
        }
    }'

    response=$(curl -s -X POST \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token $GITHUB_TOKEN" \
        "https://api.github.com/repos/$FULL_REPO/dispatches" \
        -d "$payload")

    if [[ -z "$response" ]]; then
        log_success "Test trigger sent successfully"
        echo "Check your repository's Actions tab to see if the workflow triggered."
        echo "URL: https://github.com/$FULL_REPO/actions"
    else
        log_error "Failed to send test trigger"
        echo "Response: $response"
        return 1
    fi
}

# Show setup instructions
show_instructions() {
    echo
    log_info "Webhook Setup Instructions"
    echo "==========================="
    echo
    echo "Your repository is configured to receive repository_dispatch events."
    echo "To set up automatic triggers when niri updates:"
    echo
    echo "1. Manual Trigger (Testing):"
    echo "   curl -X POST \\"
    echo "     -H 'Accept: application/vnd.github.v3+json' \\"
    echo "     -H 'Authorization: token YOUR_TOKEN' \\"
    echo "     https://api.github.com/repos/$FULL_REPO/dispatches \\"
    echo "     -d '{\"event_type\": \"niri-update\", \"client_payload\": {\"sha\": \"abc123\"}}'"
    echo
    echo "2. GitHub CLI Trigger:"
    echo "   gh workflow run 'External Repository Trigger' \\"
    echo "     --field event_type=niri-update \\"
    echo "     --field niri_ref=main \\"
    echo "     --repo $FULL_REPO"
    echo
    echo "3. Set up monitoring service (see docs/WEBHOOK_SETUP.md for details):"
    echo "   - Create a service that monitors soulvice/niri for changes"
    echo "   - Have it send repository_dispatch events to your repository"
    echo "   - Use event types: niri-update, niri-push, niri-release"
    echo
    echo "4. For automatic updates, consider:"
    echo "   - GitHub Actions in a monitoring repository"
    echo "   - External webhook service (Zapier, etc.)"
    echo "   - GitHub App with webhook capabilities"
    echo
    log_info "Next steps:"
    echo "  - Read docs/WEBHOOK_SETUP.md for detailed setup options"
    echo "  - Monitor the 'External Repository Trigger' workflow"
    echo "  - Test the integration with manual triggers"
}

# Create a simple monitoring script
create_monitor_script() {
    echo
    read -p "Create a monitoring script for periodic checks? (y/n) [n]: " CREATE_SCRIPT
    CREATE_SCRIPT=${CREATE_SCRIPT:-n}

    if [[ "$CREATE_SCRIPT" =~ ^[Yy]$ ]]; then
        cat > monitor-niri.sh << EOF
#!/bin/bash
# Niri Repository Monitor
# Run this script periodically to check for niri updates

REPO="$FULL_REPO"
TOKEN="$GITHUB_TOKEN"
NIRI_REPO="$NIRI_REPO"

# Get latest niri commit
LATEST_COMMIT=\$(curl -s "https://api.github.com/repos/\$NIRI_REPO/commits/main" | jq -r '.sha')
COMMIT_MESSAGE=\$(curl -s "https://api.github.com/repos/\$NIRI_REPO/commits/main" | jq -r '.commit.message')

echo "Latest niri commit: \$LATEST_COMMIT"

# Trigger update
curl -X POST \\
  -H "Accept: application/vnd.github.v3+json" \\
  -H "Authorization: token \$TOKEN" \\
  https://api.github.com/repos/\$REPO/dispatches \\
  -d "{
    \\"event_type\\": \\"niri-update\\",
    \\"client_payload\\": {
      \\"ref\\": \\"refs/heads/main\\",
      \\"sha\\": \\"\$LATEST_COMMIT\\",
      \\"repository\\": \\"$NIRI_REPO\\",
      \\"commit_message\\": \\"\$COMMIT_MESSAGE\\",
      \\"pusher\\": \\"monitor-script\\"
    }
  }"

echo "Update triggered for commit: \$LATEST_COMMIT"
EOF

        chmod +x monitor-niri.sh
        log_success "Created monitor-niri.sh"
        echo "Run ./monitor-niri.sh to manually check for niri updates and trigger rebuilds."
        echo "Add to cron for periodic monitoring:"
        echo "  # Check every hour"
        echo "  0 * * * * /path/to/monitor-niri.sh"
    fi
}

# Main execution
main() {
    echo "🔧 niri-flake Webhook Setup"
    echo "============================"
    echo
    echo "This script helps set up repository_dispatch webhooks to automatically"
    echo "trigger niri-flake updates when the niri repository has new commits."
    echo

    check_prerequisites
    get_repo_info
    get_github_token
    test_repo_access

    echo
    read -p "Send a test trigger to verify the setup? (y/n) [y]: " SEND_TEST
    SEND_TEST=${SEND_TEST:-y}

    if [[ "$SEND_TEST" =~ ^[Yy]$ ]]; then
        if test_trigger; then
            log_success "Webhook setup completed successfully!"
        else
            log_warning "Test trigger failed, but basic setup is complete"
        fi
    fi

    show_instructions
    create_monitor_script

    echo
    log_success "Setup complete!"
    echo "Monitor your repository's Actions tab for triggered workflows."
}

# Run main function
main "$@"