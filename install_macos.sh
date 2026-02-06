#!/bin/sh

# this file is for installing dotfiles on macOS using yadm
if [ -z "$USER" ]; then
  USER=$(id -un)
fi

cd $HOME

# Install yadm for managing dotfiles
brew install yadm

yadm clone -f https://github.com/shawnpk/dotfiles.git
yadm sparse-checkout set --no-cone '/*' '!README.md' '!LICENSE'
yadm remote set-url origin git@github.com:shawnpk/dotfiles.git

# Install LazyGit
brew install lazygit

# Install treesitter
# npm install -g tree-sitter # Skipping - not needed for LazyVim

rm -rf dotfiles
