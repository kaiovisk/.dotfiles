#!/bin/sh

# Set the time zone and generate /etc/localtime
ln -sf /usr/share/zoneinfo/America/Campo_Grande /etc/localtime
hwclock --systohc

# Generate the locales (PT_BR and EN_US)
sed -i '387s/.//' /etc/locale.gen
sed -i '171s/.//' /etc/locale.gen
locale-gen

# Set language and keymap
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf

# Setup network and hostname
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# Set root password
echo root:password | chpasswd

# Get dependencies and system tools
pacman -S --needed grub grub-btrfs efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools linux-headers \
zsh zsh-completions openssh rsync reflector acpi acpid acpi_call \
nftables firewalld os-prober ntfs-3g neovim cups bluez bluez-utils hplip samba docker

# Enable multilib repository
sed -i '93s/.//' /etc/pacman.conf
sed -i '94s/.//' /etc/pacman.conf
pacman -Syy

# Get GPU drivers (REMOVE COMMENT IF NEEDED)
# pacman -S --needed nvidia nvidia-utils nvidia-settings lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia libvdpau libxnvctrl \
# vulkan-icd-loader lib32-vulkan-icd-loader

# Install GRUB and generate config file
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB 
grub-mkconfig -o /boot/grub/grub.cfg

# Enable processes with systemd
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid

# Setup non-root user password and permissions
useradd -m -G wheel,docker -s /usr/bin/zsh kaiowski
echo kaiowski:password | chpasswd

# Append user permissions to the sudoers file
echo "kaiowski ALL=(ALL) ALL" >> /etc/sudoers.d/kaiowski

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

