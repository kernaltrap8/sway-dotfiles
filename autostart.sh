#!/usr/bin/env bash
# Autostart script for i3

function spawn() {
  if ! [ pgrep -x "$1" ]; then
    "$@" & disown
  fi
}

# Shell components
spawn env XDG_CURRENT_DESKTOP=i3 \
      XDG_SESSION_TYPE=x11 \
      XDG_SESSION_DESKTOP=i3 \
      dbus-update-activation-environment DISPLAY XDG_CURRENT_DESKTOP
spawn wlr-randr --output HDMI-A-1 --custom-mode 1920x1080@100.000000Hz
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt6ct
export GTK_THEME=Adwaita:dark
export GTK_APPLICATION_PREFER_DARK=1
export vblank_mode=1
spawn mako --background-color "#000000" --border-color "#000000" --output DP-3
spawn "$HOME/.config/i3/waybar.sh"
# spawn "$HOME/.config/wayfire/scripts/start-replay.sh"
spawn gsettings set org.gnome.desktop.interface gtk-theme Adwaita:dark
# spawn python3 "$HOME/.config/wayfire/scripts/ipc-scripts/firefox-pip-sticky.py"
spawn swaybg -i "$HOME/.config/i3/wallpapers/galaxy.png"
spawn "$HOME/.config/i3status/media.sh"
# User apps
spawn zen
spawn "$HOME/.local/share/Discord/Discord"
spawn keepassxc
spawn SFP_UI
spawn "$HOME/.config/wayfire/scripts/musicplayer-startup.sh"
spawn protonvpn-app
spawn steam
spawn dino

exit
