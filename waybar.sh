#!/bin/bash

kill $(pgrep -x waybar)
exec "$HOME/.config/i3/start-waybar.sh"
