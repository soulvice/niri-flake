#!/usr/bin/env bash
set -euo pipefail

# Documentation Viewer for Niri Home-Manager Module
# This script provides multiple ways to view the generated documentation

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
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

DOCS_PATH=""

# Check for existing docs
if [[ -f "./test-results/niri-docs" ]]; then
    DOCS_PATH="./test-results/niri-docs"
elif nix build .#niri-docs --out-link ./niri-docs-temp 2>/dev/null; then
    DOCS_PATH="./niri-docs-temp"
else
    log_warning "No documentation found. Run ./test-generator.sh first or build with 'nix build .#niri-docs'"
    exit 1
fi

log_info "Found documentation at: $DOCS_PATH"

# Function to show documentation stats
show_stats() {
    local doc_file="$1"
    echo
    log_info "Documentation Statistics:"
    echo "   📄 File size: $(du -h "$doc_file" | cut -f1)"
    echo "   📝 Lines: $(wc -l < "$doc_file")"
    echo "   🔤 Words: $(wc -w < "$doc_file")"
    echo "   📚 Sections: $(grep -c '^#' "$doc_file" || echo "0")"
    echo "   ⚙️  Options documented: $(grep -c '^###' "$doc_file" || echo "0")"
    echo
}

# Function to extract table of contents
show_toc() {
    local doc_file="$1"
    echo
    log_info "Table of Contents:"
    grep '^#' "$doc_file" | head -20 | sed 's/^/   /'
    local total_headers=$(grep -c '^#' "$doc_file" || echo "0")
    if [[ $total_headers -gt 20 ]]; then
        echo "   ... and $(($total_headers - 20)) more sections"
    fi
    echo
}

# Function to search documentation
search_docs() {
    local doc_file="$1"
    local term="$2"
    echo
    log_info "Searching for '$term' in documentation:"
    if grep -n -i --color=always "$term" "$doc_file" | head -10; then
        echo
        local matches=$(grep -c -i "$term" "$doc_file" || echo "0")
        log_success "Found $matches matches"
    else
        log_warning "No matches found for '$term'"
    fi
    echo
}

# Function to show option examples
show_examples() {
    local doc_file="$1"
    echo
    log_info "Configuration Examples:"

    # Show kebab-case examples
    if grep -A 5 -B 2 "repeat-delay\|focus-ring\|window-rules" "$doc_file" | head -20; then
        echo
        log_success "Found kebab-case option examples above"
    fi
    echo
}

# Main menu
show_menu() {
    echo
    echo "📖 Niri Documentation Viewer"
    echo "=============================="
    echo
    echo "Available actions:"
    echo "  1) View full documentation (less)"
    echo "  2) View with syntax highlighting (bat)"
    echo "  3) Show documentation statistics"
    echo "  4) Show table of contents"
    echo "  5) Search documentation"
    echo "  6) Show configuration examples"
    echo "  7) Export as HTML"
    echo "  8) Export to file"
    echo "  q) Quit"
    echo
}

# Function to export as HTML
export_html() {
    local doc_file="$1"
    local output_file="niri-docs.html"

    if command -v pandoc &> /dev/null; then
        log_info "Converting to HTML with pandoc..."
        pandoc "$doc_file" -f markdown -t html5 -s --toc --highlight-style=github -o "$output_file"
        log_success "HTML documentation saved to: $output_file"

        if command -v xdg-open &> /dev/null; then
            read -p "Open in browser? (y/N): " -r
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                xdg-open "$output_file"
            fi
        fi
    else
        log_warning "pandoc not found. Install pandoc to export as HTML."
        echo "On NixOS: nix-shell -p pandoc"
        echo "Then run: pandoc $doc_file -f markdown -t html5 -s --toc -o niri-docs.html"
    fi
}

# Function to export to custom file
export_file() {
    local doc_file="$1"
    echo
    read -p "Enter output filename: " output_file
    if [[ -n "$output_file" ]]; then
        cp "$doc_file" "$output_file"
        log_success "Documentation copied to: $output_file"
    fi
}

# Main interactive loop
main() {
    show_stats "$DOCS_PATH"

    while true; do
        show_menu
        read -p "Choose an action (1-8, q): " choice

        case $choice in
            1)
                log_info "Opening documentation with less (press 'q' to quit)"
                sleep 1
                less "$DOCS_PATH"
                ;;
            2)
                if command -v bat &> /dev/null; then
                    log_info "Opening documentation with bat"
                    bat --style=grid,header,numbers --theme=github "$DOCS_PATH"
                else
                    log_warning "bat not found. Using less instead."
                    less "$DOCS_PATH"
                fi
                ;;
            3)
                show_stats "$DOCS_PATH"
                ;;
            4)
                show_toc "$DOCS_PATH"
                ;;
            5)
                echo
                read -p "Enter search term: " search_term
                if [[ -n "$search_term" ]]; then
                    search_docs "$DOCS_PATH" "$search_term"
                fi
                ;;
            6)
                show_examples "$DOCS_PATH"
                ;;
            7)
                export_html "$DOCS_PATH"
                ;;
            8)
                export_file "$DOCS_PATH"
                ;;
            q|Q)
                log_success "Goodbye!"
                break
                ;;
            *)
                log_warning "Invalid choice. Please try again."
                ;;
        esac

        if [[ "$choice" != "3" && "$choice" != "4" ]]; then
            echo
            read -p "Press Enter to continue..." -r
        fi
    done
}

# Quick view options
if [[ $# -gt 0 ]]; then
    case "$1" in
        --stats)
            show_stats "$DOCS_PATH"
            ;;
        --toc)
            show_toc "$DOCS_PATH"
            ;;
        --search)
            if [[ $# -gt 1 ]]; then
                search_docs "$DOCS_PATH" "$2"
            else
                echo "Usage: $0 --search TERM"
                exit 1
            fi
            ;;
        --html)
            export_html "$DOCS_PATH"
            ;;
        --cat)
            cat "$DOCS_PATH"
            ;;
        --bat)
            if command -v bat &> /dev/null; then
                bat --style=grid,header,numbers --theme=github "$DOCS_PATH"
            else
                log_warning "bat not found, using cat"
                cat "$DOCS_PATH"
            fi
            ;;
        *)
            echo "Usage: $0 [--stats|--toc|--search TERM|--html|--cat|--bat]"
            echo "Or run without arguments for interactive mode"
            exit 1
            ;;
    esac
else
    main
fi

# Clean up temp file
if [[ "$DOCS_PATH" == "./niri-docs-temp" ]]; then
    rm -f ./niri-docs-temp
fi