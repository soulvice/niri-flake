#!/usr/bin/env bash

# Niri Home-Manager Module Generator Test Suite
set -euo pipefail

echo "🧪 Running Niri Home-Manager Module Generator Tests"
echo "=================================================="

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

# Test 1: Check Nix syntax
test_nix_syntax() {
    log_info "Testing Nix syntax..."

    local files=(
        "flake.nix"
        "generator/default.nix"
        "generator/parser.nix"
        "generator/type-mapper.nix"
        "generator/kdl-generator.nix"
        "generator/module-generator.nix"
        "generator/validation.nix"
        "examples/basic-config.nix"
        "examples/advanced-config.nix"
        "test.nix"
    )

    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            if nix-instantiate --parse "$file" >/dev/null 2>&1; then
                log_success "Syntax OK: $file"
            else
                log_error "Syntax error: $file"
                return 1
            fi
        else
            log_warning "File not found: $file"
        fi
    done
}

# Test 2: Run our custom test suite
test_custom_suite() {
    log_info "Running custom test suite..."

    if nix-instantiate test.nix -A runTests --eval --strict 2>/dev/null; then
        log_success "Custom tests passed"
    else
        log_error "Custom tests failed"
        log_info "Running individual tests for debugging..."

        local test_cases=(
            "testParser"
            "testTypeMapper"
            "testKdlGenerator"
            "testModuleGenerator"
            "testIntegration"
            "testValidation"
            "testDocumentationGenerator"
        )

        for test in "${test_cases[@]}"; do
            if nix-instantiate test.nix -A "$test" --eval --strict >/dev/null 2>&1; then
                log_success "✓ $test"
            else
                log_error "✗ $test"
            fi
        done
        return 1
    fi
}

# Test 3: Check flake evaluation
test_flake_evaluation() {
    log_info "Testing flake evaluation..."

    if command -v nix >/dev/null 2>&1; then
        # Test flake check (if available)
        if nix flake check --no-build 2>/dev/null; then
            log_success "Flake check passed"
        else
            log_warning "Flake check failed or not supported"
        fi

        # Test building the generator
        if nix build .#generator --no-link 2>/dev/null; then
            log_success "Generator builds successfully"
        else
            log_error "Generator failed to build"
            return 1
        fi

        # Test building the documentation
        if nix build .#niri-docs --no-link 2>/dev/null; then
            log_success "Documentation builds successfully"
        else
            log_error "Documentation failed to build"
            return 1
        fi
    else
        log_warning "Nix command not available, skipping flake tests"
    fi
}

# Test 4: Validate example configurations
test_example_configs() {
    log_info "Validating example configurations..."

    local examples=(
        "examples/basic-config.nix"
        "examples/advanced-config.nix"
    )

    for example in "${examples[@]}"; do
        if [[ -f "$example" ]]; then
            if nix-instantiate --eval --strict "$example" >/dev/null 2>&1; then
                log_success "Example validates: $example"
            else
                log_error "Example invalid: $example"
                return 1
            fi
        fi
    done
}

# Test 5: Check documentation
test_documentation() {
    log_info "Checking documentation..."

    local docs=(
        "README.md"
        "docs/USAGE.md"
    )

    for doc in "${docs[@]}"; do
        if [[ -f "$doc" ]]; then
            if [[ -s "$doc" ]]; then
                log_success "Documentation exists: $doc"
            else
                log_warning "Documentation empty: $doc"
            fi
        else
            log_warning "Documentation missing: $doc"
        fi
    done
}

# Test 6: Validate GitHub Actions workflow
test_github_actions() {
    log_info "Validating GitHub Actions workflow..."

    local workflow=".github/workflows/update-niri-module.yml"

    if [[ -f "$workflow" ]]; then
        # Basic YAML syntax check
        if command -v python3 >/dev/null 2>&1; then
            if python3 -c "import yaml; yaml.safe_load(open('$workflow'))" 2>/dev/null; then
                log_success "GitHub Actions workflow is valid YAML"
            else
                log_error "GitHub Actions workflow has invalid YAML syntax"
                return 1
            fi
        else
            log_warning "Python3 not available, cannot validate YAML syntax"
        fi

        log_success "GitHub Actions workflow exists"
    else
        log_warning "GitHub Actions workflow missing"
    fi
}

# Main test runner
main() {
    local failed=0

    echo
    log_info "Starting test suite..."
    echo

    # Run all tests
    test_nix_syntax || ((failed++))
    echo

    test_custom_suite || ((failed++))
    echo

    test_flake_evaluation || ((failed++))
    echo

    test_example_configs || ((failed++))
    echo

    test_documentation || ((failed++))
    echo

    test_github_actions || ((failed++))
    echo

    # Summary
    echo "=================================================="
    if [[ $failed -eq 0 ]]; then
        log_success "🎉 All tests passed!"
        echo
        log_info "The niri home-manager module generator is ready for use."
        echo
        echo "Next steps:"
        echo "1. Update flake.nix with actual niri repository details"
        echo "2. Test with real niri source code"
        echo "3. Set up GitHub Actions for automation"
        echo "4. Publish the flake for others to use"
    else
        log_error "❌ $failed test(s) failed"
        echo
        log_info "Please fix the failing tests before proceeding."
        exit 1
    fi
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi