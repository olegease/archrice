#!/bin/zsh

# user
read "t_? your username: " && export yo_user=$t_
[ -z "$yo_user" ] && echo "username cannot be empty" && exit 1
read -s "t_? your password: " && export yo_pass=$t_ && unset t_
[ -z "$yo_pass" ] && echo "password cannot be empty" && exit 1
read -s "t_? repeat password: " && yo_pass_=$t_ && unset t_
[ "$yo_pass" != "$yo_pass_" ] && echo "user passwords mismatch" && exit 1
echo
unset yo_pass_
# root
read -s "t_? root password, (root): " && yo_root_=$t_ && unset t_
[ -z "$yo_root_" ] && export yo_root="root" || export yo_root=$yo_root_
[ "$yo_root" != "root" ] && read -s "yo_root_? repeat password: " || yo_root_=$yo_root
[ "$yo_root" != "$yo_root_" ] && echo "root passwords mismatch" && exit 1
unset yo_root_
# device
[ -d /sys/firmware/efi ] && export yo_uefi=efibootmgr
echo $yo_uefi
read "t_? your device, (/dev/)...: " && export yo_device=/dev/$t_
export yo_deswap=${yo_device}1
export yo_depast=${yo_device}2
export yo_deroot=${yo_device}3
export yo_deboot=${yo_device}4
[ -n "$yo_uefi" ] && export yo_deuefi=${yo_device}5 || export yo_debios=${yo_device}5
export yo_decode=${yo_device}6
export yo_dedata=${yo_device}7
export yo_dehome=${yo_device}8
read "t_? device swap size, (*)G: " && export yo_szswap="+${t_}G"
read "t_? device past size, (*)G: " && export yo_szpast="+${t_}G"
read "t_? device root size, (*)G: " && export yo_szroot="+${t_}G"
export yo_szboot="+2G"
[ -n "$yo_uefi" ] && export yo_szuefi="+1G" || export yo_szbios="+1M"
read "t_? device code size, (*)G: " && export yo_szcode="+${t_}G"
read "t_? device data size, (*)G: " && export yo_szdata="+${t_}G"
# home size is rest of the device remaining size
export yo_szhome="0"
# other
read "t_? your keyboard mappings, (us): " && export yo_keys=$t_
[ -z "$yo_keys" ] && yo_keys=us
read "t_? your locale, (en_US.UTF-8): " && export yo_lang=$t_
[ -z "$yo_lang" ] && yo_lang=en_US.UTF-8
read "t_? your zone, (Europe/London): " && export yo_zone=$t_
[ -z "$yo_zone" ] && yo_zone=Europe/London 
[ -n "$yo_uefi" ] && export yo_host_=modern || export yo_host_=legacy
read "t_? your hostname, (${yo_host_}): " && export yo_host=$t_
[ -z "$yo_host" ] && export yo_host=$yo_host_
unset yo_host_


unset t_