#!/bin/bash

ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Remove existing directory before linking
rm -rf ~/.config/nvim
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
rm -rf ~/.config/ghostty
ln -sf ~/.dotfiles/.config/ghostty ~/.config/ghostty



