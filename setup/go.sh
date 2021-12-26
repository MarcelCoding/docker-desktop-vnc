#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  wget -O- https://go.dev/dl/go1.17.5.linux-amd64.tar.gz | tar -xzvC /usr/local
  echo "export PATH=\$PATH:/usr/local/go/bin" >>"/home/${USER}/.bashrc"
fi
