#!/usr/bin/env sh

function setup_space {
    local idx="$1"
    local name="$2"
    local space=
    echo "setup space $idx : $name"
    
    space=$(yabai -m query --spaces --space "$idx")
    if [ -z "$space" ]; then
        yabai -m space --create
    fi
    
    yabai -m space "$idx" --label "$name"
}

# Initialize spaces
setup_space 1 communication
setup_space 2 daily
setup_space 3 coding
setup_space 4 classbro

sketchybar --trigger space_change --trigger windows_on_spaces