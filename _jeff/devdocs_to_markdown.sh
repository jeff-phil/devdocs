#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Default directory configurations
INPUT_DIR="devdocs"
OUTPUT_DIR="dist"

# Helper function to print script usage
show_help() {
    echo "Usage: $(basename "$0") [options]"
    echo ""
    echo "Options:"
    echo "  -i, --input-dir   <path>   Directory containing source HTML files (Default: '.')"
    echo "  -o, --output-dir  <path>   Directory where Markdown files go (Default: '../dist')"
    echo "  -h, --help                 Show this help screen"
    exit 0
}

# Parse command line arguments manually for clean option matching
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--input-dir)
            if [[ -z "$2" || "$2" == -* ]]; then
                echo "Error: Missing value for --input-dir" >&2
                exit 1
            fi
            INPUT_DIR="$2"
            shift 2
            ;;
        -o|--output-dir)
            if [[ -z "$2" || "$2" == -* ]]; then
                echo "Error: Missing value for --output-dir" >&2
                exit 1
            fi
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo "Unknown argument: $1" >&2
            show_help
            ;;
    esac
done

# Resolve absolute path for clean execution context
ABS_INPUT_DIR=$(cd "$INPUT_DIR" && pwd)
mkdir -p "$OUTPUT_DIR"
ABS_OUTPUT_DIR=$(cd "$OUTPUT_DIR" && pwd)

# Counters for summary report
TOTAL_CONVERTED=0

# Detect SED flavor and assign the appropriate command and flags on the fly
BREW_GNU_SED="/opt/homebrew/opt/gnu-sed/libexec/gnubin/sed"

if [ -x "$BREW_GNU_SED" ]; then
    SED_CMD="$BREW_GNU_SED -i -E"
    SED_FLAVOR="Homebrew GNU sed"
elif command -v gsed >/dev/null 2>&1; then
    SED_CMD="gsed -i -E"
    SED_FLAVOR="System GNU gsed"
else
    SED_CMD="sed -i '' -E"
    SED_FLAVOR="macOS BSD sed"
fi

# ... (Keep everything above the find command exactly the same) ...

echo "=================================================="
echo "Starting DevDocs HTML to Markdown Conversion..."
echo "Detected Engine: $SED_FLAVOR"
echo "Source:          $ABS_INPUT_DIR"
echo "Destination:     $ABS_OUTPUT_DIR"
echo "=================================================="

# FIX: Changed from "find ... | while read" to a process substitution loop
while read -r dir; do
    
    rel_path=""
    if [ "$dir" != "$ABS_INPUT_DIR" ]; then
        rel_path="${dir#$ABS_INPUT_DIR/}"
    fi
    
    if [[ "$ABS_OUTPUT_DIR" == "$dir"* ]]; then
        continue
    fi
    
    if [ -z "$rel_path" ]; then
        target_dir="$ABS_OUTPUT_DIR"
    else
        target_dir="$ABS_OUTPUT_DIR/$rel_path"
    fi
    
    html_files_exist=$(find "$dir" -maxdepth 1 -name "*.html" -print -quit)
    if [ -z "$html_files_exist" ]; then
        continue
    fi

    mkdir -p "$target_dir"
    
    for file in "$dir"/*.html; do
        [ -e "$file" ] || continue
        
        filename=$(basename "$file" .html)
        output_file="$target_dir/$filename.md"
        
        if [ -z "$rel_path" ]; then
            echo "Converting: $filename.html"
        else
            echo "Converting: $rel_path/$filename.html"
        fi
        
        html2markdown --input "$file" --output "$output_file"
        
        if [ -f "$output_file" ]; then
            eval "$SED_CMD 's/\]\(([^)]+)\.html([^)]*)\)/](\1.md\2)/g' \"\$output_file\""
            # This variable updates in the main shell context now
            TOTAL_CONVERTED=$((TOTAL_CONVERTED + 1))
        fi
    done

# The '< <(...)' syntax executes the search stream without creating a subshell split
done < <(find "$ABS_INPUT_DIR" -type d)

echo "=================================================="
echo "Conversion complete!"
echo "Total Markdown files created and linked: $TOTAL_CONVERTED"
echo "=================================================="

