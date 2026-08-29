#!/bin/bash

ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.aerospace.toml ~/.aerospace.toml

# Remove existing directory before linking
rm -rf ~/.config/nvim
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
rm -rf ~/.config/ghostty
ln -sf ~/.dotfiles/.config/ghostty ~/.config/ghostty

# Tmux with configuration directory
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
rm -rf ~/.tmux
ln -sf ~/.dotfiles/.tmux ~/.tmux
