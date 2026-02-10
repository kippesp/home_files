#!/bin/bash
# Requirements: jq (for JSON parsing), bc (for floating point arithmetic)

input=$(cat)

if ! command -v jq &> /dev/null; then
    echo "Error: jq not found"
    exit 1
fi

model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
cwd=$(echo "$input" | jq -r '.cwd // ""')

if [[ -z "$cwd" ]]; then
    cwd=$(pwd)
fi

if (( $(echo "$pct > 0" | bc -l) )); then
    context="${pct%.*}%"
else
    context="--%"
fi

home="${USERPROFILE:-$HOME}"
if [[ -n "$home" && "$cwd" == "$home"* ]]; then
    rel="~${cwd#$home}"
    rel="${rel//\\//}"
else
    rel="$cwd"
fi

echo "$model | $context used | $rel"
