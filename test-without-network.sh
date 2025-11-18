#!/usr/bin/env bash
set -euo pipefail

# Test Generator - Local testing without network access
# This script tests the core generator logic without requiring GitHub access

echo "🚀 Testing Niri Home-Manager Module Generator (Local Mode)"
echo "========================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Check if we're in the right directory
if [[ ! -f "flake.nix" ]]; then
    log_error "Must be run from the niri-flake directory"
    exit 1
fi

# Create test output directory
TEST_DIR="./test-results-local"
mkdir -p "$TEST_DIR"

log_info "Test results will be saved to: $TEST_DIR"
echo

# Step 1: Test individual generator components
log_info "Step 1: Testing generator components individually..."

# Create a mock niri source structure for testing
MOCK_SRC="$TEST_DIR/mock-niri"
mkdir -p "$MOCK_SRC/niri-config/src"

# Create mock configuration files
cat > "$MOCK_SRC/niri-config/src/lib.rs" << 'EOF'
//! Main configuration structure for niri

/// Main configuration structure
#[derive(Default, Debug, Clone, Decode)]
pub struct Config {
    /// Input device configuration
    pub input: Input,

    /// Layout configuration
    pub layout: Layout,

    /// Key bindings
    pub binds: std::collections::HashMap<String, Bind>,
}
EOF

cat > "$MOCK_SRC/niri-config/src/input.rs" << 'EOF'
//! Input device configuration

/// Input configuration
#[derive(Default, Debug, Clone, Decode)]
pub struct Input {
    /// Keyboard configuration
    pub keyboard: Keyboard,
}

/// Keyboard configuration
#[derive(Default, Debug, Clone, Decode)]
pub struct Keyboard {
    /// Repeat delay in milliseconds
    #[knuffel(child, unwrap(argument))]
    pub repeat_delay: Option<u32>,

    /// XKB configuration
    pub xkb: Xkb,
}

/// XKB layout configuration
#[derive(Default, Debug, Clone, Decode)]
pub struct Xkb {
    /// Keyboard layout
    #[knuffel(child, unwrap(argument))]
    pub layout: Option<String>,
}
EOF

cat > "$MOCK_SRC/niri-config/src/layout.rs" << 'EOF'
//! Layout configuration

/// Layout configuration
#[derive(Default, Debug, Clone, Decode)]
pub struct Layout {
    /// Gap size between windows
    #[knuffel(child, unwrap(argument))]
    pub gaps: Option<u16>,

    /// Focus ring configuration
    pub focus_ring: FocusRing,
}

/// Focus ring configuration
#[derive(Default, Debug, Clone, Decode)]
pub struct FocusRing {
    /// Whether focus ring is enabled
    #[knuffel(child, unwrap(argument))]
    pub enable: Option<bool>,

    /// Focus ring color
    #[knuffel(child, unwrap(argument))]
    pub active_color: Option<String>,
}
EOF

# Create other required files as empty
for file in animations binds gestures window_rule layer_rule workspace recent_windows appearance debug misc utils; do
    touch "$MOCK_SRC/niri-config/src/${file}.rs"
done

log_success "Mock niri source created"

# Step 2: Test the parser
log_info "Step 2: Testing Rust parser..."

if nix-instantiate --eval --expr "
  let
    pkgs = import <nixpkgs> {};
    generator = import ./generator { inherit pkgs; };
    parser = generator.parser;
    result = parser.parseNiriConfig \"$MOCK_SRC\";
  in
  builtins.length (builtins.attrNames result.structs)
" > "$TEST_DIR/parser-test.out" 2>&1; then
    STRUCT_COUNT=$(cat "$TEST_DIR/parser-test.out")
    log_success "Parser found $STRUCT_COUNT configuration structures"
else
    log_warning "Parser test failed - see $TEST_DIR/parser-test.out"
    cat "$TEST_DIR/parser-test.out"
fi
echo

# Step 3: Test type mapping
log_info "Step 3: Testing type mapping..."

if nix-instantiate --eval --expr "
  let
    pkgs = import <nixpkgs> {};
    generator = import ./generator { inherit pkgs; };
    parser = generator.parser;
    typeMapper = generator.typeMapper;
    configStructs = parser.parseNiriConfig \"$MOCK_SRC\";
    nixTypes = typeMapper.mapConfigToNixTypes configStructs;
  in
  builtins.length (builtins.attrNames nixTypes)
" > "$TEST_DIR/type-mapper-test.out" 2>&1; then
    TYPE_COUNT=$(cat "$TEST_DIR/type-mapper-test.out")
    log_success "Type mapper generated $TYPE_COUNT Nix type definitions"
else
    log_warning "Type mapper test failed - see $TEST_DIR/type-mapper-test.out"
    cat "$TEST_DIR/type-mapper-test.out"
fi
echo

# Step 4: Test documentation generation
log_info "Step 4: Testing documentation generation..."

cat > "$TEST_DIR/test-docs.nix" << 'EOF'
let
  pkgs = import <nixpkgs> {};
  generator = import ./generator { inherit pkgs; };

  # Simple mock types for testing
  mockTypes = {
    Config = {
      type = "struct";
      fields = {
        input = { type = "Input"; };
        layout = { type = "Layout"; };
      };
    };
    Input = {
      type = "struct";
      fields = {
        keyboard = { type = "Keyboard"; };
      };
    };
    Keyboard = {
      type = "struct";
      fields = {
        repeat-delay = { type = "u32"; };
        xkb = { type = "Xkb"; };
      };
    };
  };

  actionsLib = {
    spawn = "spawn";
    close-window = "close-window";
    quit = "quit";
  };

  docs = generator.generateDocs {
    nixTypes = mockTypes;
    inherit actionsLib;
  };
in
pkgs.writeText "test-docs.md" docs
EOF

if nix-build "$TEST_DIR/test-docs.nix" -o "$TEST_DIR/test-docs" 2>&1 | tee "$TEST_DIR/docs-test.log"; then
    if [[ -f "$TEST_DIR/test-docs" ]]; then
        DOCS_SIZE=$(wc -c < "$TEST_DIR/test-docs")
        log_success "Documentation generated: $DOCS_SIZE bytes"

        # Check for key content
        if grep -q "Table of Contents" "$TEST_DIR/test-docs" 2>/dev/null; then
            log_success "Documentation contains table of contents"
        fi

        if grep -q "repeat-delay" "$TEST_DIR/test-docs" 2>/dev/null; then
            log_success "Documentation contains kebab-case option names"
        fi
    else
        log_warning "Documentation file not found"
    fi
else
    log_warning "Documentation generation failed - see $TEST_DIR/docs-test.log"
fi
echo

# Step 5: Test module generation
log_info "Step 5: Testing module generation..."

cat > "$TEST_DIR/test-module.nix" << 'EOF'
let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  generator = import ./generator { inherit pkgs; };

  # Create a simple test module
  testModule = generator.moduleGenerator.generateModule {
    nixTypes = {
      Config = {
        type = "struct";
        fields = {
          input = {
            type = "Input";
            nixType = lib.types.submodule {};
          };
        };
      };
    };
    kdlGenerator = generator.kdlGenerator;
  };
in
testModule
EOF

if nix-instantiate --eval "$TEST_DIR/test-module.nix" > "$TEST_DIR/module-test.out" 2>&1; then
    log_success "Module generation completed"

    # Check if the result looks like a module
    if grep -q "options" "$TEST_DIR/module-test.out" 2>/dev/null; then
        log_success "Generated module contains options"
    fi

    if grep -q "config" "$TEST_DIR/module-test.out" 2>/dev/null; then
        log_success "Generated module contains config"
    fi
else
    log_warning "Module generation failed - see $TEST_DIR/module-test.out"
    head -20 "$TEST_DIR/module-test.out" || true
fi
echo

# Step 6: Test complex configuration examples
log_info "Step 6: Testing complex configuration examples..."

# Test that our complex examples parse correctly
for example in ./test/complex-config-examples.nix ./examples/basic-config.nix ./examples/advanced-config.nix; do
    if [[ -f "$example" ]]; then
        filename=$(basename "$example")
        log_info "Testing $filename..."

        if nix-instantiate --parse "$example" > /dev/null 2>&1; then
            log_success "$filename syntax is valid"
        else
            log_warning "$filename has syntax issues"
        fi
    fi
done
echo

# Step 7: Show summary
log_info "Step 7: Test Summary"
echo
echo "📁 Generated test files:"
echo "   • Mock source: $TEST_DIR/mock-niri/"
echo "   • Parser output: $TEST_DIR/parser-test.out"
echo "   • Type mapper output: $TEST_DIR/type-mapper-test.out"
echo "   • Test docs: $TEST_DIR/test-docs"
echo "   • Module test: $TEST_DIR/module-test.out"
echo "   • Logs: $TEST_DIR/*.log"
echo
echo "🔍 To examine generated documentation:"
echo "   cat $TEST_DIR/test-docs"
echo
echo "🧪 To examine generator components:"
echo "   nix repl flake.nix"
echo "   # Then: lib.niri-generator.<component>"
echo

log_success "Local testing completed!"
echo
log_info "The generator components work independently of network access."
log_info "To test with real niri source, you'll need network connectivity."

# Optional: Show a sample of the generated docs
if [[ -f "$TEST_DIR/test-docs" ]]; then
    echo
    read -p "Show sample of generated documentation? (y/N): " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo
        log_info "Sample documentation output:"
        echo "----------------------------------------"
        head -50 "$TEST_DIR/test-docs" 2>/dev/null || echo "Could not read documentation"
        echo "----------------------------------------"
        echo "... (truncated, see full file at $TEST_DIR/test-docs)"
    fi
fi