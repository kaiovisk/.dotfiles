#!/bin/bash

# Ensure packages are up to date.
sudo pacman -Syu

# Essentials.
sudo pacman -S --needed git base-devel

# Install yay.
git clone https://aur.archlinux.org/yay.git /tmp/yay/
cd /tmp/yay/ && makepkg -si && cd ~

# Browser.
# Keep firefox since some programs use it by default (for example cargo).
yay -S firefox qutebrowser --no-confirm

# Fonts.  This is very large, maybe use smaller package.
yay -S nerd-fonts-jetbrains-mono bdf-unifont wqy-zenhei ttf-liberation --no-confirm

# Manuals.
yay -S man-db --no-confirm

# Utilities.
yay -S feh scrot zathura zathura-pdf-mupdf-git gnome-calculator btop nvtop thunar flameshot brightnessctl pfetch bottom dunst --no-confirm

# Icons.
yay -S papirus-icon-theme --no-confirm

# LY Login manager.
yay -S sddm --no-confirm

# Audio.
yay -S alsa-utils pipewire pipewire-alsa pipewire-audio pipewire-docs lib32-pipewire wireplumber pavucontrol --no-confirm 

# Bluetooth.
yay -S blueman --no-confirm 
systemctl enable bluetooth.service && systemctl restart bluetooth.service
sudo sed -i 's/#AutoEnable=false/AutoEnable=true/g' /etc/bluetooth/main.conf # Enable on startup.

# Terminal.
yay -S alacritty --no-confirm

# Coding stuff.
yay -S neovim --no-confirm

# Gaming stuff.
yay -S steam steam-tui steamcmd heroic-games-launcher lutris goverlay mangohud libstrangle --no-confirm
# Setup gamemode.
yay -S gamemode lib32-gamemode --no-confirm
systemctl --user enable gamemoded 
# Setup VKBasalt.
yay -S vkbasalt --no-confirm
mkdir ~/.config/vkBasalt && cp /usr/share/vkBasalt/vkBasalt.conf.example ~/.config/vkBasalt/vkBasalt.conf

# Communication.
yay -S thunderbird discord --no-confirm

# i3 stuff.
yay -S i3-wm nitrogen lxappearance rofi picom --no-confirm
# Stuff for polybar.
yay -S polybar --no-confirm

# Media.
yay -S vlc spotify --no-confirm

# Setup optimus manager.
# NB: For Nvidia cards only!
yay -S optimus-manager gdm-prime nvidia-settings nvidia-force-comp-pipeline --no-confirm 
sudo touch /etc/optimus-manager/optimus-manager.conf 
sudo sh -c "echo '[optimus]' > /etc/optimus-manager/optimus-manager.conf" 
sudo sh -c "echo 'startup_mode=nvidia' > /etc/optimus-manager/optimus-manager.conf" 
nvidia-force-composition-pipeline
systemctl enable optimus-manager && systemctl start optimus-manager &

# Install lock screen.
yay -S betterlockscreen-git --no-confirm
# Setup lock screen.
# Should this script run every time the screens change?  Yeah.
betterlockscreen -u ~/.wallpapers/alice_in_starry_night --blur 0.5
betterlockscreen -u ~/.wallpapers/alice_in_starry_night.jpg

