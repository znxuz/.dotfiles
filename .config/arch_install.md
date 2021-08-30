# Pre-Install

## Internet Connection
```sh
device list
station <device> scan
station <device> get-networks
station <device> connect
iwctl --passphrase <password> station <device> connect <SSID>
```

## Start
```sh
timedatectl set-ntp true
pacman -Syyy &&& pacman -S reflector
reflector -c Germany -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyy
```

## Disk Partition
```sh
fdisk <disk>
d # clean whole partition
g # create a gpt disk
n
	# partition number 1
	# first sector: empty
	# last sector: (give size:) +200M
t
	# change boot partition to type 1
n
	# root, home partitions
# ...
mkfs.fat -F32 /dev/vda1
mkfs.ext4 /dev/vda2
# ...
```

## Mount
```sh
mount /dev/vda2 /mnt # root
mkdir /mnt/boot
# mkdir /mnt/home
mount /dev/vda1 /mnt/boot
# ...
```

## pacstrap
```sh
pacstrap /mnt base base-devel linux linux-firmware man-db man-pages texinfo vim
```

## genfstab
```sh
genfstab -U /mnt >> /mnt/etc/fstab
# cat /mnt/etc/fstab
```

# Chroot
```sh
arch-chroot /mnt
```

## After chroot
```sh
timedatectl list-timezones | grep Berlin
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
vim /etc/locale.gen # uncomment UTF-8 locale
locale-gen
vim /etc/locale.conf # LANG=en_US.UTF-8
vim /etc/hostname # arch
vim /etc/hosts
	# 127.0.0.1		localhost
	# ::1			localhost
	# 127.0.1.1		arch.localdomain	arch
passwd # root password

pacman -S grub efibootmgr networkmanager wireless_tools \
	dialog os-prober linux-headers reflector git bluez bluez-utils cups \
	xdg-utils xdg-user-dirs openssh wpa_supplicant

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd


useradd -mG wheel <username>
passwd # <username>

EDITOR=vim visudo # sudo vim /etc/sudoers
	# uncomment  whell ALL(ALL) ALL NOPASSWD: ALL

exit
umount -a
reboot
```

# Post-Install

## Connect via ssh
```sh
# wlan
nmtui
	# nmcli device wifi list
	# nmcli device wifi connect SSID password password

sudo pacman -S xorg xorg-xinit
sudo pacman -S sxhkd bspwm alacritty zsh

chsh -s /bin/zsh
# git clone https://aur.archlinux.org/dropbox.git
	# gpg --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E

# clone dotfiles repo
git clone --separate-git-dir=~/.dotfiles \
	https://github.com/Zyanite7/.dotfiles.git ~/dotfiles.tmp
```
