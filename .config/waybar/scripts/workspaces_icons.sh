#!/bin/bash

get_icon() {
    local app=$1
    case $app in
        "firefox") echo "🦊" ;;
        "chrome"|"chromium") echo "🌐" ;;
        "code") echo "💻" ;;
        "terminal"|"alacritty"|"kitty") echo "🖥️" ;;
        "thunar"|"dolphin"|"nautilus") echo "📁" ;;
        *) echo "${app:0:1}" | tr '[:lower:]' '[:upper:]' ;;
    esac
}

get_workspace_info() {
    workspaces=$(hyprctl workspaces -j | jq -r 'sort_by(.id) | .[].id')
    active_workspace=$(hyprctl activeworkspace -j | jq -r '.id')
    output=""

    for workspace in $workspaces; do
        windows=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $workspace)")
        if [ ! -z "$windows" ]; then
            app=$(echo "$windows" | jq -r '.class' | head -n 1 | tr '[:upper:]' '[:lower:]')
            icon=$(get_icon "$app")
            if [ "$workspace" = "$active_workspace" ]; then
                output="$output<span foreground='#ff9e64'>$workspace:$icon</span> "
            else
                output="$output$workspace:$icon "
            fi
        else
            if [ "$workspace" = "$active_workspace" ]; then
                output="$output<span foreground='#ff9e64'>$workspace:·</span> "
            else
                output="$output$workspace:· "
            fi
        fi
    done

    # Trim the trailing space
    output=$(echo "$output" | sed 's/ $//')

    # Output as JSON
    echo "{\"text\": \"$output\", \"tooltip\": \"$output\"}"
}

get_workspace_info
