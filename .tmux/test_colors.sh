#!/usr/bin/env bash

set -euo pipefail

SOCKET="tmux-color-test"

# Update this list if you add new required colors to your theme files
required_colors=(
    @status_bar_bg
    @active_text_color
    @inactive_text_color
    @active_bg_color
    @inactive_bg_color
)

themes=( "$HOME/.tmux/colors/"*.conf )

tmux -L "$SOCKET" -f /dev/null new-session -d

cleanup() {
    tmux -L "$SOCKET" kill-server 2>/dev/null || true
}
trap cleanup EXIT

for theme in "${themes[@]}"; do
    echo "Testing $(basename "$theme")..."

    tmux -L "$SOCKET" source-file "$theme"

    for color in "${required_colors[@]}"; do
        value=$(tmux -L "$SOCKET" show-options -gqv "$color")

        if [[ -z "$value" ]]; then
            echo "  ✗ Missing: $color"
            exit 1
        fi

        echo "  ✓ $color = $value"
    done
done

echo
echo "All themes passed."
