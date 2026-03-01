#!/bin/zsh

source config/export.sh
# showing export values for debugging purposes, but hiding passwords
echo "debug variables:"
echo yo_user: $yo_user
echo -n yo_pass: && [ -z "$yo_pass" ] && echo " error: password is empty" || echo " ****"
echo yo_root: "****"
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
mkfs.ext4 -L PAST $yo_depast
mkfs.ext4 -L ROOT $yo_deroot
mkfs.nilfs2 -L HOME $yo_dehome
[ -n "$yo_uefi" ] && mkfs.fat -n UEFI -F 32 $yo_deuefi
# mounting
echo "mounting partitions..."
swapon -L SWAP
mount -L ROOT /mnt
mount -L BOOT --mkdir /mnt/boot
mount -L HOME --mkdir /mnt/home
[ -n "$yo_uefi" ] && mount -L UEFI --mkdir /mnt/boot/efi


# after user creation
#unset $yo_root
#unset $yo_pass