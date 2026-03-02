#!/bin/zsh
set -e
source config/export.sh
# showing export values for debugging purposes, but hiding passwords
echo "debug variables:"
echo yo_user: $yo_user
echo yo_device: $yo_device
echo yo_deswap: $yo_deswap: $yo_szswap
echo yo_depast: $yo_depast: $yo_szpast
echo yo_deroot: $yo_deroot: $yo_szroot
echo yo_deboot: $yo_deboot: $yo_szboot
echo yo_deuefi: $yo_deuefi
echo yo_decode: $yo_decode: $yo_szcode
echo yo_dedata: $yo_dedata: $yo_szdata
echo yo_dehome: $yo_dehome
echo yo_zone: $yo_zone
echo yo_lang: $yo_lang
echo yo_keys: $yo_keys
echo yo_host: $yo_host
# partitioning
echo "partitioning device $yo_device..."
set +e
swapoff $yo_deswap
umount -R /mnt
set -e
sgdisk -Z $yo_device
sgdisk -n:0:0:$yo_szswap -t:0:8200 -c:0:SWAP $yo_device
sgdisk -n:0:0:$yo_szpast -t:0:8300 -c:0:PAST $yo_device
sgdisk -n:0:0:$yo_szroot -t:0:8304 -c:0:ROOT $yo_device
sgdisk -n:0:0:$yo_szboot -t:0:EA00 -c:0:BOOT $yo_device
[ -n "$yo_uefi" ] && sgdisk -n:0:0:$yo_szuefi -t:0:EF00 -c:0:UEFI $yo_device
[ -z "$yo_uefi" ] && sgdisk -n:0:0:$yo_szbios -t:0:EF02 -c:0:BIOS $yo_device
sgdisk -n:0:0:$yo_szcode -t:0:8300 -c:0:CODE $yo_device
sgdisk -n:0:0:$yo_szdata -t:0:8300 -c:0:DATA $yo_device
sgdisk -n:0:0:$yo_szhome -t:0:8302 -c:0:HOME $yo_device
# making sure all partitions are wiped before formatting
echo "wiping partitions..."
wipefs -a $yo_deswap
wipefs -a $yo_depast
wipefs -a $yo_deroot
wipefs -a $yo_deboot
[ -n "$yo_uefi" ] && wipefs -a $yo_deuefi
[ -z "$yo_uefi" ] && wipefs -a $yo_debios
wipefs -a $yo_decode
wipefs -a $yo_dedata
wipefs -a $yo_dehome
# formatting
echo "formatting partitions..."
mkswap -L SWAP $yo_deswap
mkfs.ext4 -L ROOT $yo_deroot
mkfs.ext4 -L BOOT $yo_deboot
mkfs.nilfs2 -L HOME $yo_dehome
[ -n "$yo_uefi" ] && mkfs.fat -n UEFI -F 32 $yo_deuefi
# mounting
echo "mounting partitions..."
swapon -L SWAP
mount -L ROOT /mnt
mount -L BOOT --mkdir /mnt/boot
mount -L HOME --mkdir /mnt/home
[ -n "$yo_uefi" ] && mount -L UEFI --mkdir /mnt/boot/efi
# pacstrap
echo "installing base system..."
mkdir /mnt/etc
echo "KEYMAP=$yo_keys" > /mnt/etc/vconsole.conf
pacstrap -K /mnt base base-devel linux linux-firmware neovim networkmanager grub $yo_uefi
arch-chroot /mnt /bin/bash -c '
    ln -s /usr/bin/nvim /usr/bin/vi
    ln -sf /usr/share/zoneinfo/$yo_zone /etc/localtime
    hwclock --systohc
    echo "$yo_lang UTF-8" >> /etc/locale.gen
    locale-gen
    echo LANG=$yo_lang > /etc/locale.conf
    echo $yo_host > /etc/hostname
    [ -z "${yo_uefi}" ] && grub-install --target=i386-pc $yo_device
    [ -n "${yo_uefi}" ] && grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
    useradd -m $yo_user
    usermod -aG wheel $yo_user
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$yo_user
    chpasswd <<< "$yo_user:$yo_pass"
    unset $yo_pass
    chpasswd <<< "root:$yo_root"
    unset $yo_root
    mkdir /root/past
    mkdir /home/$yo_user/{code,data}
    exit
'
# post install
echo "post install steps..."
mkfs.btrfs -L PAST $yo_depast
mkfs.xfs -L DATA $yo_dedata
mkfs.f2fs -l CODE -O extra_attr,compression $yo_decode
mount -L PAST -o compress=zstd:8 /mnt/root/past
mount -L DATA /mnt/home/$yo_user/data
mount -L CODE -o $yo_compress /mnt/home/$yo_user/code
chown -R 1000:1000 /mnt/home/$yo_user
genfstab -U /mnt > /mnt/etc/fstab
umount -R /mnt
echo "installation complete, you can now reboot into your new system"
