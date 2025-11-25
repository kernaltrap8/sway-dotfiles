#!/usr/bin/env bash
# Autostart script for i3

function spawn() {
  bname=$(basename "$1")
  if ! pgrep -f -x "$bname"; then
    "$@" & disown
  fi
}

# Shell components
dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
spawn wlr-randr --output HDMI-A-1 --custom-mode 1920x1080@100.000000Hz
spawn /usr/libexec/xdg-desktop-portal-wlr -r
spawn mako --background-color "#000000" --border-color "#000000" --output DP-3
spawn gentoo-pipewire-launcher restart
# spawn "$HOME/.config/i3/waybar.sh"
# spawn "$HOME/.config/wayfire/scripts/start-replay.sh"
spawn gsettings set org.gnome.desktop.interface gtk-theme Adwaita:dark
# spawn python3 "$HOME/.config/wayfire/scripts/ipc-scripts/firefox-pip-sticky.py"
spawn swaybg -i $HOME/.config/i3/wallpapers/galaxy.png
spawn "$HOME/.config/i3status/media.sh"
spawn swayidle -w \
         timeout 300 'if ! playerctl --all-players status 2>/dev/null | grep -q "^Playing$"; then swaylock -f -c 000000; fi' \
         timeout 600 'if ! playerctl --all-players status 2>/dev/null | grep -q "^Playing$"; then swaymsg "output * dpms off"; fi' \
          resume 'swaymsg "output * dpms on"'

# User apps
spawn zen
spawn "$HOME/.local/share/Discord/Discord"
spawn keepassxc
spawn SFP_UI
spawn "$HOME/.config/wayfire/scripts/musicplayer-startup.sh"
spawn protonvpn-app
#spawn steam # weird startup behavior... spawns a bunch of chromium windows. will keep commented until fix'd
spawn dino

exit
