# Re-emit GFM with YAML frontmatter and raw HTML/XML tags made visible:
# frontmatter as a fenced yaml block, tags as backslash-escaped text,
# comments and CDATA as a fenced html block. Source line structure is kept.
# Reader: ~/.local/share/pandoc/custom/skillmd.lua
#
# Usage: mdescape [FILE]        reads stdin when FILE is omitted
#
# Examples:
#   mdescape SKILL.md | glowrf -
#   mdescape SKILL.md > SKILL.escaped.md
#
# Without pandoc, prints the input unchanged.
mdescape() {
    if ! command -v pandoc >/dev/null 2>&1; then
        echo "mdescape: pandoc not found; input passed through" >&2
        cat "$@"
        return
    fi

    pandoc -f skillmd.lua -t gfm --wrap=preserve "$@"
}
