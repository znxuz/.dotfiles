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
pacman -Syyy &&& pacman -S reflector archlinux-keyring
reflector -c Germany -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyy
```

## Disk Partition

```sh
fdisk <disk>
EFI: change type of partition to 'EFI system partition'
LVM: change type of partition to 'Linux LVM'
```

### dm-crypt

```sh
cryptsetup luksFormat /dev/sda2
cryptsetup open /dev/sda2 cryptlvm
pvcreate /dev/mapper/cryptlvm
vgcreate volgrp /dev/mapper/cryptlvm
lvcreate -L 40G volgrp -n root
lvcreate -l 75%FREE volgrp -n home
```

### format partitions

```sh
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/volgrp/root
mkfs.ext4 /dev/volgrp/home
```

## Mount

```sh
mount /dev/volgrp/root /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount /dev/sda1 /mnt/boot
# ...
```

## pacstrap

```sh
pacstrap /mnt base base-devel linux linux-firmware man-db man-pages
	#[intel/amd]-ucode lvm2 vim
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

## Setup

```sh
# timedatectl list-timezones | grep Berlin
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

# pacman parallel download
pacman -S grub <*-ucode> efibootmgr networkmanager wireless_tools texinfo \
	dialog os-prober linux-headers reflector git bluez bluez-utils cups \
	xdg-utils xdg-user-dirs openssh wpa_supplicant
```

### lvm
vim /etc/mkinitcpio.conf

```sh
HOOKS=(base udev microcode autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)
mkinitcpio -p linux
```


### grub

```sh
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
# lvm
uuid=$(blkid --match-tag UUID -o value /dev/nvme0n1p2)
vim /etc/default/grub
GRUB_CMDLINE_LINUX="cryptdevice=UUID=${uuid}:cryptlvm root=/dev/volgrp/root"
grub-mkconfig -o /boot/grub/grub.cfg
```


```sh
systemctl enable NetworkManager bluetooth sshd


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

sudo pacman -S xorg xorg-xinit sxhkd bspwm alacritty zsh archlinux-keyring

chsh -s /bin/zsh

# install dotfiles
```
