#!/bin/bash

# Render markdown with glow, re-flowing hard-wrapped paragraphs to the
# display width.  pandoc joins the wrapped lines; glow re-wraps them.
# Usage: glowrf [GLOW_OPTIONS] FILE
#
# Examples:
#   glowrf README.md             # Re-flow to the width set in glow.yml
#   glowrf -w 120 -p README.md   # Re-flow to 120 columns, with pager
#
# Without pandoc, falls back to plain glow (no re-flow).
glowrf() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: glowrf [GLOW_OPTIONS] FILE" >&2
        return 1
    fi

    if ! command -v glow >/dev/null 2>&1; then
        echo "glowrf: glow not found" >&2
        return 1
    fi

    if ! command -v pandoc >/dev/null 2>&1; then
        echo "glowrf: pandoc not found; paragraphs not re-flowed" >&2
        glow "$@"
        return
    fi

    pandoc --wrap=none -f gfm -t gfm "${!#}" | glow "${@:1:$#-1}" -
}
