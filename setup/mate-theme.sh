#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  apt-get install -y arc-theme breeze-cursor-theme numix-icon-theme

  cp -r ./themes/* /usr/share/themes/
  gsettings set org.gnome.desktop.interface gtk-theme "MarcelCoding"
fi
