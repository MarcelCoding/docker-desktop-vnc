#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
  echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb $(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d = -f 2) main" | tee /etc/apt/sources.list.d/adoptopenjdk.list
  apt-get update
  apt-get install -y --no-install-recommends adoptopenjdk-15-hotspot adoptopenjdk-11-hotspot
fi
