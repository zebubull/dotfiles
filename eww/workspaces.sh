#!/usr/bin/env bash

update() {
    hyprctl workspaces -j | jq -Mc 'map({id: .id, windows: .windows}) | sort_by(.id)'
}

update
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	update
done
