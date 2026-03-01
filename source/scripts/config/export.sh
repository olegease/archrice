#!/bin/bash
# user
# read -p "your username: " t_ && export yo_user=$t_
# [ -z "$yo_user" ] && echo "username cannot be empty" && exit 1
# read -sp "your password: " t_ && export yo_pass=$t_ && unset t_
# [ -z "$yo_pass" ] && echo "password cannot be empty" && exit 1
# read -sp "reapeat password: " t_ && yo_pass_=$t_ && unset t_ && echo
# [ "$yo_pass" != "$yo_pass_" ] && echo "user passwords mismatch" && exit 1
# unset $yo_pass_
# root
# read -sp "root password, (root): " t_ && yo_root_=$t_ && unset t_
# [ -z "$yo_root_" ] && export yo_root="root" || export yo_root=$yo_root_
# [ "$yo_root" != "root" ] && read -sp "repeat password: " yo_root_ || yo_root_=$yo_root && echo
# [ "$yo_root" != "$yo_root_" ] && echo "root passwords mismatch" && exit 1
# unset $yo_root_
# device
[ -d /sys/firmware/efi ] && export yo_uefi=efibootmgr
echo $yo_uefi
read -p "your device, (/dev/)...: " t_ && export yo_device=/dev/$t_ && unset t_
export yo_deswap=${yo_device}1
export yo_depast=${yo_device}2
export yo_deroot=${yo_device}3
export yo_deboot=${yo_device}4
[ -n "$yo_uefi" ] && export yo_deuefi=${yo_device}5
export yo_decode=${yo_device}6
export yo_dedata=${yo_device}7
export yo_dehome=${yo_device}8
# other
read -p "your keyboard mappings, (us): " t_ && export yo_keys=$t_ && echo
[ -z "$yo_keys" ] && yo_keys=us
read -p "your locale, (en_US.UTF-8): " t_ && export yo_lang=$t_ && echo
[ -z "$yo_lang" ] && yo_lang=en_US.UTF-8
read -p "your zone, (Europe/London): " t_ && export yo_zone=$t_ && echo
[ -z "$yo_zone" ] && yo_zone=Europe/London 
