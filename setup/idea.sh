#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  echo "intellij"
  wget -O- "https://download-cf.jetbrains.com/idea/ideaIU-2020.2.3.tar.gz" | tar -xzC /opt
fi
