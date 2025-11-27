#!/usr/bin/env bash
# Autostart script for i3

> $HOME/startup.log

function spawn() {
    local cmd="$1"
    shift
    local bname=$(basename "$cmd")
    if ! pgrep -f -x "$bname" >/dev/null; then
        echo "[LOG] $cmd $*" >> /home/charlotte/startup.log
        "$cmd" "$@" >> /home/charlotte/startup.log 2>&1 &
        disown
    fi
}

# Shell components
dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway 
spawn gentoo-pipewire-launcher restart
sleep 1
spawn /usr/libexec/xdg-desktop-portal-wlr -r
spawn mako --background-color "#000000" --border-color "#000000" --output HDMI-A-1
spawn gsettings set org.gnome.desktop.interface gtk-theme Adwaita:dark
#spawn swaybg -i $HOME/.config/i3/wallpapers/galaxy.png # moved to main config due to socket issues
spawn "$HOME/.config/i3status/media.sh"
spawn swayidle -w \
         timeout 300 'if ! playerctl --all-players status 2>/dev/null | grep -q "^Playing$"; then swaylock -f -c 000000; fi' \
         timeout 600 'if ! playerctl --all-players status 2>/dev/null | grep -q "^Playing$"; then swaymsg "output * dpms off"; fi' \
          resume 'swaymsg "output * dpms on"'

# User apps
spawn zen
#spawn discord
spawn keepassxc
spawn "$HOME/.config/i3/musicplayer-startup.sh"
spawn protonvpn-app
spawn dino

exit
