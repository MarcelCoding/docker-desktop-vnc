#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

# see: https://github.com/felbinger/PostInstall/blob/master/scripts/installJetBrainsToolbox.sh

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  wget -O- "https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-1.18.7455.tar.gz" | tar xz --strip 1 -C /usr/local/bin
fi
