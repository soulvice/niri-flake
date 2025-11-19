# Webhook Setup Guide

This guide explains how to set up webhooks to automatically trigger niri-flake updates when the niri repository has new commits.

## Overview

The niri-flake repository can be configured to automatically update when:
- New commits are pushed to the `soulvice/niri` repository
- New releases are published in the niri repository
- Pull requests are created (for testing)

This is achieved using GitHub's `repository_dispatch` events and webhooks.

## Methods

### Method 1: Repository Webhooks (Recommended)

This method uses GitHub webhooks to trigger updates immediately when niri has new commits.

#### Prerequisites

- Admin access to your niri-flake repository
- A GitHub Personal Access Token with `repo` permissions

#### Setup Steps

1. **Create a Personal Access Token**
   ```bash
   # Go to GitHub Settings > Developer settings > Personal access tokens
   # Create a new token with 'repo' scope
   # Save the token securely
   ```

2. **Set up the webhook service**

   You'll need a webhook service that listens for niri repository changes and forwards them to your niri-flake repository. Here are options:

   **Option A: GitHub Actions in niri repository (if you can add workflows)**
   ```yaml
   # .github/workflows/notify-downstream.yml in soulvice/niri
   name: Notify Downstream Repositories
   on:
     push:
       branches: [main]
   jobs:
     notify:
       runs-on: ubuntu-latest
       steps:
         - name: Notify niri-flake
           run: |
             curl -X POST \
               -H "Accept: application/vnd.github.v3+json" \
               -H "Authorization: token ${{ secrets.DOWNSTREAM_TOKEN }}" \
               https://api.github.com/repos/YOUR_USERNAME/niri-flake/dispatches \
               -d '{
                 "event_type": "niri-update",
                 "client_payload": {
                   "ref": "${{ github.ref }}",
                   "sha": "${{ github.sha }}",
                   "repository": "soulvice/niri",
                   "commit_message": "${{ github.event.head_commit.message }}",
                   "pusher": "${{ github.event.pusher.name }}"
                 }
               }'
   ```

   **Option B: External webhook service (Zapier, webhook.site, custom server)**

   Create a webhook service that:
   1. Listens for GitHub webhooks from `soulvice/niri`
   2. Filters for push events to main branch
   3. Triggers repository_dispatch on your niri-flake repo

   **Option C: GitHub App (Most robust)**

   Create a GitHub App that monitors the niri repository and triggers updates.

3. **Test the webhook**
   ```bash
   # Manual test using curl
   curl -X POST \
     -H "Accept: application/vnd.github.v3+json" \
     -H "Authorization: token YOUR_TOKEN" \
     https://api.github.com/repos/YOUR_USERNAME/niri-flake/dispatches \
     -d '{
       "event_type": "niri-update",
       "client_payload": {
         "ref": "refs/heads/main",
         "sha": "abc123",
         "repository": "soulvice/niri",
         "commit_message": "Test update",
         "pusher": "test-user"
       }
     }'
   ```

### Method 2: GitHub CLI Script

Use this script to manually trigger updates or set up periodic checks:

```bash
#!/bin/bash
# check-niri-updates.sh

REPO="YOUR_USERNAME/niri-flake"
TOKEN="YOUR_GITHUB_TOKEN"

# Get latest niri commit
LATEST_COMMIT=$(curl -s "https://api.github.com/repos/soulvice/niri/commits/main" | jq -r '.sha')
COMMIT_MESSAGE=$(curl -s "https://api.github.com/repos/soulvice/niri/commits/main" | jq -r '.commit.message')

echo "Latest niri commit: $LATEST_COMMIT"

# Trigger update
curl -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $TOKEN" \
  https://api.github.com/repos/$REPO/dispatches \
  -d "{
    \"event_type\": \"niri-update\",
    \"client_payload\": {
      \"ref\": \"refs/heads/main\",
      \"sha\": \"$LATEST_COMMIT\",
      \"repository\": \"soulvice/niri\",
      \"commit_message\": \"$COMMIT_MESSAGE\",
      \"pusher\": \"automated-check\"
    }
  }"

echo "Update triggered for commit: $LATEST_COMMIT"
```

### Method 3: Periodic Monitoring Service

Set up a service (cron job, GitHub Actions in a separate repo, cloud function) that periodically checks for niri updates:

```yaml
# In a separate "monitoring" repository
name: Check Niri Updates
on:
  schedule:
    - cron: '*/30 * * * *'  # Every 30 minutes
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - name: Check for niri updates
        run: |
          # Check latest niri commit
          LATEST_COMMIT=$(curl -s "https://api.github.com/repos/soulvice/niri/commits/main" | jq -r '.sha')

          # Check if this is different from last known commit
          # (store in repository variable or file)

          # If different, trigger niri-flake update
          if [[ "$LATEST_COMMIT" != "$LAST_KNOWN_COMMIT" ]]; then
            curl -X POST \
              -H "Authorization: token ${{ secrets.NIRI_FLAKE_TOKEN }}" \
              https://api.github.com/repos/YOUR_USERNAME/niri-flake/dispatches \
              -d '{
                "event_type": "niri-update",
                "client_payload": {
                  "sha": "'$LATEST_COMMIT'",
                  "repository": "soulvice/niri"
                }
              }'
          fi
```

## Workflow Triggers

The niri-flake repository responds to these `repository_dispatch` event types:

| Event Type | Description | When to Use |
|------------|-------------|-------------|
| `niri-update` | Standard update trigger | New commits to main branch |
| `niri-push` | Any push event | All pushes (branches, tags) |
| `niri-release` | New release | Official releases only |
| `niri-pr` | Pull request events | Testing purposes |

## Payload Format

When triggering `repository_dispatch`, use this payload format:

```json
{
  "event_type": "niri-update",
  "client_payload": {
    "ref": "refs/heads/main",
    "sha": "commit-sha-here",
    "repository": "soulvice/niri",
    "commit_message": "Commit message here",
    "pusher": "username-who-pushed",
    "timestamp": "2024-01-01T00:00:00Z"
  }
}
```

## Security Considerations

1. **Token Security**: Store GitHub tokens as repository secrets
2. **Repository Validation**: The workflow validates that triggers come from `soulvice/niri`
3. **Rate Limiting**: Be mindful of GitHub API rate limits
4. **Webhook Validation**: Validate webhook signatures when possible

## Troubleshooting

### Common Issues

1. **Workflow doesn't trigger**
   - Check that the event type matches exactly
   - Verify the repository name is correct
   - Ensure the token has proper permissions

2. **Trigger works but update fails**
   - Check the "Update Niri Module" workflow logs
   - Verify the niri commit SHA is valid
   - Check for network issues

3. **Too many triggers**
   - Implement rate limiting in your webhook service
   - Use conditional logic to avoid unnecessary updates

### Debugging

```bash
# Check recent workflow runs
gh run list --repo YOUR_USERNAME/niri-flake --workflow="external-repo-trigger.yml"

# View specific run logs
gh run view RUN_ID --repo YOUR_USERNAME/niri-flake

# Manual trigger for testing
gh workflow run "External Repository Trigger" \
  --field event_type=niri-update \
  --field niri_ref=main \
  --repo YOUR_USERNAME/niri-flake
```

## Monitoring

The webhook system creates logs and issues for failures:
- Successful triggers are logged in workflow runs
- Failed triggers create GitHub issues automatically
- Monitor the "External Repository Trigger" workflow for health

## Alternative: Manual Triggers

You can always trigger updates manually:

```bash
# Using GitHub CLI
gh workflow run "Update Niri Module" \
  --field force_update=true \
  --field niri_ref=main \
  --repo YOUR_USERNAME/niri-flake

# Using web interface
# Go to Actions tab > "Update Niri Module" > "Run workflow"
```