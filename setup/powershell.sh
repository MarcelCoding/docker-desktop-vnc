#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
  dpkg -i packages-microsoft-prod.deb
  apt-get update
  add-apt-repository universe
  apt-get update
  apt-get install -y --no-install-recommends powershell
fi
