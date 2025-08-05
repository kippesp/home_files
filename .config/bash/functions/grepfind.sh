#!/bin/bash

# Search for a pattern within files matching a filename pattern
# Usage: grepfind <search_pattern> <filename_pattern> [directory]
# 
# Examples:
#   grepfind "error" "log"           # Search for "error" in files containing "log"
#   grepfind "function" "*.js" src/  # Search for "function" in JS files under src/
#   grepfind "TODO" "*.py"           # Search for "TODO" in Python files
grepfind() {
    local search_pattern="$1"
    local filename_pattern="$2"
    local search_dir="${3:-.}"  # Default to current directory
    
    # Validate arguments
    if [[ -z "$search_pattern" || -z "$filename_pattern" ]]; then
        echo "Usage: grepfind <search_pattern> <filename_pattern> [directory]" >&2
        echo "Examples:" >&2
        echo "  grepfind 'error' 'log'           # Search for 'error' in files containing 'log'" >&2
        echo "  grepfind 'function' '*.js' src/  # Search for 'function' in JS files under src/" >&2
        echo "  grepfind 'TODO' '*.py'           # Search for 'TODO' in Python files" >&2
        return 1
    fi
    
    # Check if directory exists
    if [[ ! -d "$search_dir" ]]; then
        echo "Error: Directory '$search_dir' does not exist" >&2
        return 1
    fi
    
    # Check if ripgrep is available
    if command -v rg >/dev/null 2>&1; then
        # Use ripgrep (preferred method)
        echo "Using ripgrep..." >&2
        rg --files-with-matches -i "$search_pattern" --iglob "**/*${filename_pattern}*" "$search_dir"
    else
        # Fallback to find + grep
        echo "Using find + grep fallback..." >&2
        find "$search_dir" -type f -iname "*${filename_pattern}*" -print0 | \
            xargs -0 grep -i -l "$search_pattern" 2>/dev/null
    fi
}

# Alternative version with more options
# Usage: grepfind-advanced [options] <search_pattern> <filename_pattern> [directory]
grepfind-advanced() {
    local case_sensitive=false
    local show_content=false
    local search_pattern=""
    local filename_pattern=""
    local search_dir="."
    
    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--case-sensitive)
                case_sensitive=true
                shift
                ;;
            -s|--show-content)
                show_content=true
                shift
                ;;
            -h|--help)
                echo "Usage: grepfind-advanced [options] <search_pattern> <filename_pattern> [directory]"
                echo "Options:"
                echo "  -c, --case-sensitive    Case-sensitive search (default: case-insensitive)"
                echo "  -s, --show-content      Show matching lines (default: just filenames)"
                echo "  -h, --help             Show this help message"
                echo ""
                echo "Examples:"
                echo "  grepfind-advanced 'Error' 'log'                    # Case-insensitive search"
                echo "  grepfind-advanced -c 'Error' 'log'                 # Case-sensitive search"
                echo "  grepfind-advanced -s 'function' '*.js' src/        # Show matching lines"
                return 0
                ;;
            -*)
                echo "Unknown option: $1" >&2
                return 1
                ;;
            *)
                if [[ -z "$search_pattern" ]]; then
                    search_pattern="$1"
                elif [[ -z "$filename_pattern" ]]; then
                    filename_pattern="$1"
                else
                    search_dir="$1"
                fi
                shift
                ;;
        esac
    done
    
    # Validate required arguments
    if [[ -z "$search_pattern" || -z "$filename_pattern" ]]; then
        echo "Error: Both search_pattern and filename_pattern are required" >&2
        grepfind-advanced --help
        return 1
    fi
    
    # Check if directory exists
    if [[ ! -d "$search_dir" ]]; then
        echo "Error: Directory '$search_dir' does not exist" >&2
        return 1
    fi
    
    # Build command based on available tools and options
    if command -v rg >/dev/null 2>&1; then
        # Use ripgrep
        local rg_cmd="rg"
        
        # Add case sensitivity option
        if [[ "$case_sensitive" == false ]]; then
            rg_cmd="$rg_cmd -i"
        fi
        
        # Add output format option
        if [[ "$show_content" == false ]]; then
            rg_cmd="$rg_cmd --files-with-matches"
        fi
        
        # Add glob pattern
        if [[ "$case_sensitive" == false ]]; then
            rg_cmd="$rg_cmd --iglob"
        else
            rg_cmd="$rg_cmd --glob"
        fi
        
        echo "Using ripgrep..." >&2
        eval "$rg_cmd \"**/*${filename_pattern}*\" \"$search_pattern\" \"$search_dir\""
    else
        # Fallback to find + grep
        local grep_opts=""
        local find_opts="-iname"
        
        if [[ "$case_sensitive" == false ]]; then
            grep_opts="-i"
        else
            find_opts="-name"
        fi
        
        if [[ "$show_content" == false ]]; then
            grep_opts="$grep_opts -l"
        fi
        
        echo "Using find + grep fallback..." >&2
        find "$search_dir" -type f $find_opts "*${filename_pattern}*" -print0 | \
            xargs -0 grep $grep_opts "$search_pattern" 2>/dev/null
    fi
}
