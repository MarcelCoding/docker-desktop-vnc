#!/usr/bin/env bash

# every exit != 0 fails the script
# set -e

# see: https://github.com/felbinger/PostInstall/blob/master/scripts/installGoogleChrome.sh

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
  apt-get install --no-install-recommends -y -f
fi
