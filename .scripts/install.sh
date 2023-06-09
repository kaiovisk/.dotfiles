#!/bin/bash

# Ensure packages are up to date.
sudo pacman -Syu

# Essentials.
sudo pacman -S --needed git base-devel

# Install yay.
git clone https://aur.archlinux.org/yay.git /tmp/yay/
cd /tmp/yay/ && makepkg -si && cd ~

# Use yay to get pamac.
# yay -S libpamac-full pamac-all (support for snap and flatpak, which I won't use, but anyways).
yay -S libpamac-aur pamac-aur # Only AUR.
sudo pacman -Syu polkit-gnome  
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf

# Browser.
# Keep firefox since some programs use it by default (for example cargo).
sudo pamac install firefox brave --no-confirm

# Some aesthetic stuff.
sudo pamac install cmatrix bonsai.sh-git pipes.sh lolcat shell-color-scripts --no-confirm

# Fonts.  This is very large, maybe use smaller package.
sudo pamac install nerd-fonts-jetbrains-mono bdf-unifont wqy-zenhei ttf-liberation --no-confirm

# Manuals.
sudo pamac install man-db --no-confirm

# Utilities.
sudo pamac install scrot zathura zathura-pdf-mupdf-git cpu-x fuse-common powertop speedtest-cli gnome-calculator balena-etcher btop nvtop thunar flameshot brightnessctl pfetch bottom dunst --no-confirm

# Icons.
sudo pamac install papirus-icon-theme --no-confirm

# LY Login manager.
sudo pamac install ly --no-confirm

# Audio.
sudo pamac install alsa-utils pipewire pipewire-alsa pipewire-audio pipewire-docs lib32-pipewire wireplumber pavucontrol --no-confirm 

# Bluetooth.
sudo pamac install blueman --no-confirm 
systemctl enable bluetooth.service && systemctl restart bluetooth.service
sudo sed -i 's/#AutoEnable=false/AutoEnable=true/g' /etc/bluetooth/main.conf # Enable on startup.

# Terminal.
sudo pamac install alacritty --no-confirm

# Coding stuff.
sudo pamac install neovim ripgreps --no-confirm

# Gaming stuff.
sudo pamac install steam steam-tui steamcmd heroic-games-launcher lutris goverlay mangohud libstrangle --no-confirm
# Setup gamemode.
sudo pamac install gamemode lib32-gamemode --no-confirm
systemctl --user enable gamemoded 
# Setup VKBasalt.
sudo pamac install vkbasalt --no-confirm
mkdir ~/.config/vkBasalt && cp /usr/share/vkBasalt/vkBasalt.conf.example ~/.config/vkBasalt/vkBasalt.conf

# Communication.
sudo pamac install thunderbird whatsapp-nativefier discord signal-desktop --no-confirm

# i3 stuff.
sudo pamac install nitrogen lxappearance rofi picom --no-confirm
# Stuff for polybar.
sudo pamac install polybar python-pywal pywal-git networkmanager-dmenu-git calc --no-confirm

# Media.
sudo pamac install playerctl spotify --no-confirm

# Power management.
sudo pamac install tlp --no-confirm
systemctl enable tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
sudo tlp start

# Setup optimus manager.
# NB: For Nvidia cards only!
sudo pamac install optimus-manager gdm-prime nvidia-settings nvidia-force-comp-pipeline --no-confirm 
sudo touch /etc/optimus-manager/optimus-manager.conf 
sudo sh -c "echo '[optimus]' > /etc/optimus-manager/optimus-manager.conf" 
sudo sh -c "echo 'startup_mode=nvidia' > /etc/optimus-manager/optimus-manager.conf" 
nvidia-force-composition-pipeline
systemctl enable optimus-manager && systemctl start optimus-manager &

# Enable SysRq keys.
sudo touch /etc/sysctl.d/99-sysctl.conf
sudo sh -c "echo 'kernel.sysrq=1' >> /etc/sysctl.d/99-sysctl.conf"

# Install lock screen.
sudo pamac install betterlockscreen-git --no-confirm
# Setup lock screen.
# Should this script run every time the screens change?  Yeah.
betterlockscreen -u ~/.wallpapers/alice_in_starry_night --blur 0.5
betterlockscreen -u ~/.wallpapers/alice_in_starry_night.jpg

