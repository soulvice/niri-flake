#!/usr/bin/env bash

# Build comprehensive documentation for niri-flake
# This script generates the complete MODULE_OPTIONS.md file

set -euo pipefail

echo "🔧 Building niri-flake comprehensive documentation..."

# Check if we're in the right directory
if [[ ! -f "flake.nix" ]]; then
    echo "❌ Error: Please run this script from the niri-flake root directory"
    exit 1
fi

# Generate the documentation
echo "📖 Generating documentation from niri source..."
nix build -f generate-docs.nix --out-link result-docs

# Copy to the docs directory
echo "📁 Copying documentation to docs/MODULE_OPTIONS.md..."
cp result-docs/MODULE_OPTIONS.md docs/

# Clean up build result
rm -f result-docs

echo "✅ Documentation generated successfully!"
echo "📖 View the documentation: docs/MODULE_OPTIONS.md"
echo ""
echo "The documentation includes:"
echo "  - Complete module options reference"
echo "  - All ${actionsLib_count:-100}+ available actions"
echo "  - Type reference and validation rules"
echo "  - Configuration examples and troubleshooting"
echo ""
echo "To view the documentation:"
echo "  cat docs/MODULE_OPTIONS.md"
echo "  # or open in your preferred markdown viewer"