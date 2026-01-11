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

# Install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Install treesitter
npm install -g tree-sitter

rm -rf dotfiles
