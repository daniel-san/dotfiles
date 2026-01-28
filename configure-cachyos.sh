#!/bin/bash

# Update key ring
sudo cachyos-rate-mirrors;
sudo pacman -Sy archlinux-keyring;

# Install needed packages
sudo pacman -S hyprpolkitagent hyprpaper hyprlock hypridle hypersunset dunst waybar quickshell hyprlauncher cachyos-gaming-applications cachyos-gaming-meta;

# Installing misc apps
sudo pacman -S vivaldi fuse2 yay lf

# Installing some aur packages
yay -S tofi

# Clone dotfiles
mkdir -p ~/repos;
git clone https://github.com/daniel-san/dotfiles ~/repos/dotfiles;

# Link for hyprland configs
ln -S $HOME/repos/dotfiles/.config/hypr $HOME/.config/hypr;
ln -S $HOME/repos/dotfiles/.config/waybar $HOME/.config/waybar;
ln -S $HOME/repos/dotfiles/.config/tofi $HOME/.config/tofi;

# Links for zsh configs
ln -S $HOME/repos/dotfiles/.zshrc $HOME/.zshrc
ln -S $HOME/repos/dotfiles/.zshrc.d $HOME/.zshrc.d
