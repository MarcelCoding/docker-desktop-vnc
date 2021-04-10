#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  curl -fsSL https://deb.nodesource.com/setup_lts.x | -E bash -
  apt-get install -y nodejs
fi
