#!/bin/bash
# Adapted for Swaybar (i3bar protocol)
set -eou pipefail

player="strawberry"

# Wait until the player appears
while ! playerctl -l 2>/dev/null | grep -q "$player"; do
    sleep 0.1
done

pause=""
play=""

sanitize() {
    echo "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

check_player() {
    pgrep -x "$player" > /dev/null
}

# i3bar header
echo '{ "version": 1 }'
echo '['
echo '[]'

prev_status_media=""
prev_text=""
prev_tooltip=""
prev_status_playpause=""

while true; do
    # Update player instance
    if check_player; then
        ytmn=$(playerctl -l 2>/dev/null | grep "$player" | head -n1 || true)
    else
        ytmn=""
    fi

    if ! check_player || [[ -z "$ytmn" ]]; then
        # Player not running
        text="Nothing playing"
        playpause="$play"
        echo "[{\"full_text\": \"$playpause\"}, {\"full_text\": \"$text\"}],"
        sleep 2
        continue
    fi

    # Get metadata
    read -r status artist title album < <(playerctl -p "$ytmn" metadata --format '{{status}}|{{xesam:artist}}|{{xesam:title}}|{{xesam:album}}' | tr '|' '\n')

    artist=$(sanitize "${artist-}")
    title=$(sanitize "${title-}")
    album=$(sanitize "${album-}")

    # Play/pause symbol
    if [[ "$status" == "Playing" ]]; then
        playpause="$pause"
        class="playing"
    else
        playpause="$play"
        class="paused"
    fi

    text="$artist - $title"

    # Only update if content changed
    if [[ "$prev_text" != "$text" || "$prev_status_playpause" != "$playpause" ]]; then
        echo "[{\"full_text\": \"$playpause\", \"class\": \"$class\"}, {\"full_text\": \"$text\", \"class\": \"$class\"}],"
        prev_text="$text"
        prev_status_playpause="$playpause"
    fi

    sleep 2
done
