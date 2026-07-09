#!/bin/bash
# Run this ONCE right after a fresh installation of whatever distro

echo "Starting system configuration..."

# the usual (update apt catalogue)
sudo apt update

# things I'll usually want or use (NOT every single apt I currently have)
# stuff like OBS or Steam might depend on the package manager of the distro, idk if Id want the apt necessarily, so I'm omitting them
sudo apt install -y finger zsh zsh-autosuggestions zsh-syntax-highlighting git curl vlc 

# install ohmyzsh and switch to zsh
sh -c "$(curl -fsSL https://githubusercontent.com)" "" --unattended && chsh -s $(which zsh)

# fix the Login Screen timezone offset
sudo timedatectl set-timezone $(cat /etc/timezone)

# global cursor size fix for X11 stuff (will be ignored by wayland)
echo "Xcursor.size: 32" >> ~/.Xresources
xrdb -merge ~/.Xresources

# language input methods for ZH,JA (fcitx6 might come out in 2030 or who knows when; ignore version worry)
sudo apt install -y fcitx5 fcitx5-frontend-gtk3 fcitx5-configtool fcitx-mozc fcitx5-chinese-addons

# fonts
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections

PACKAGES_FONTS=(
    fonts-firacode
    fonts-jetbrains-mono
    fonts-hack
    fonts-inter
    fonts-roboto
    fonts-lato
    fonts-open-sans
    fonts-noto-core
    ttf-mscorefonts-installer
    fonts-liberation
    fonts-cantarell
    fonts-ubuntu
)

sudo apt install -y "${PACKAGES_FONTS[@]}"
sudo fc-cache -fv

echo "Setup complete! Restart now."
