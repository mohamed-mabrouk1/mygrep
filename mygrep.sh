#!/bin/bash

# Print usage
usage() {
    echo "Usage: $0 [OPTIONS] SEARCH_STRING FILE"
    echo "Options:"
    echo "  -n       Show line numbers"
    echo "  -v       Invert match"
    echo "  --help   Show this help message"
}

# Default flags
show_line_numbers=false
invert_match=false

# Option parsing
while [[ "$1" == -* ]]; do
    case "$1" in
        -n) show_line_numbers=true ;;
        -v) invert_match=true ;;
        --help) usage; exit 0 ;;
        -*) 
            # Allow combined flags like -vn or -nv
            optchars="${1:1}"
            for (( i=0; i<${#optchars}; i++ )); do
                case "${optchars:$i:1}" in
                    n) show_line_numbers=true ;;
                    v) invert_match=true ;;
                    *) echo "Unknown option: -${optchars:$i:1}"; usage; exit 1 ;;
                esac
            done
            ;;
    esac
    shift
done

# Validate arguments
if [ $# -lt 2 ]; then
    echo "Error: Missing search string or file."
    usage
    exit 1
fi

search_string="$1"
file="$2"

if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Read the file line by line
line_num=0
while IFS= read -r line; do
    ((line_num++))
    if echo "$line" | grep -iqF "$search_string"; then
        match=true
    else
        match=false
    fi

    if { $match && ! $invert_match; } || { ! $match && $invert_match; }; then
        if $show_line_numbers; then
            echo "$line_num:$line"
        else
            echo "$line"
        fi
    fi
done < "$file"
