#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  wget -O- https://golang.org/dl/go1.16.3.linux-amd64.tar.gz | tar -xzvC /usr/local
  echo "export PATH=\$PATH:/usr/local/go/bin" >>"/home/${USER}/.bashrc"
fi
