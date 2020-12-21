#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  apt-get install -y --no-install-recommends g++
  wget "https://sh.rustup.rs" -O "rustup-init"
  chmod +x rustup-init
  sudo -u "${USER}" -g "${GROUP}" ./rustup-init -y
  rm rustup-init
fi
