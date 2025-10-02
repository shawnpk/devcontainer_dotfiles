#!/bin/sh

# this file is for installing dotfiles in devcontainer/codespace using yadm
if [ -z "$USER" ]; then
  USER=$(id -un)
fi

cd $HOME

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

# Update apt package cache
sudo apt-get update

# Install yadm for managing dotfiles
sudo apt-get install -y yadm
yadm clone -f https://github.com/shawnpk/dotfiles.git
yadm sparse-checkout set --no-cone '/*' '!README.md' '!LICENSE'
yadm remote set-url origin git@github.com:shawnpk/dotfiles.git

rm -rf dotfiles
