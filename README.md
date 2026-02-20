# ARCHRICE

> Arch installation on typical bios or uefi devices with completely REMOVING data

> Caution: for iso from 2026-02-01

## Installation

#### Export and preparation

```bash
# setfont ter-c28b
# timedatectl
# ping ping.archlinux.org
```

- TODO add wifi and other connections link

- list of available devices

```bash
# lsblk -f
```

Examples:
- user: john
- host: local
- lang: en_US.UTF-8
- keys: us
- device: /dev/sda | /dev/vda | /dev/nvme0n1 (if ends on digit add `p` to partition exports before 1-8 digit )
- zone: Atlantic/Madeira
- uefi: efibootmgr if UEFI else empty

```bash
# [ -d /sys/firmware/efi ] && export yo_uefi=efibootmgr
# export yo_exts_=s,asm,css,html,md,txt,c,h,cc,hh,hpp,cpp,js,mjs,hxx,cxx
# export yo_compress="compress_extension=${yo_exts//,/,compress_extension=}"
# export yo_user=your-user-name
# export yo_host=your-host-name
# export yo_zone=your-zone-name
# export yo_keys=your-keymap
# export yo_lang=your-locale
# export yo_device=your-device-name
# export yo_deswap=${yo_device}1
# export yo_depast=${yo_device}2
# export yo_deroot=${yo_device}3
# export yo_deboot=${yo_device}4
# [ -n "${yo_uefi}" ] && export yo_deuefi=${yo_device}5
# export yo_decode=${yo_device}6
# export yo_dedata=${yo_device}7
# export yo_dehome=${yo_device}8
```

#### Partition
> Completely Format DISK (wipefs)

```bash
# wipefs -a $yo_device
```

- Create partitions with `gdisk`, `!` is required file `system`
  - for now 512G disk size oriented

>| # | NAME | CODE | SIZE | SYSTEM |        PATH        | COMMENT |
>|---|------|------|------|--------|--------------------|---------|
>| 1 | SWAP | 8200 |   8G |   --   |         --         | Linux swap |
>| 2 | PAST | 8300 |  80G | btrfs  | /root/past         | timeshift, compression zsd:8 |
>| 3 | ROOT | 8304 |  48G | ext4   | /                  | Linux root x86_64 |
>| 4 | BOOT | EA00 |   2G | ext4!  | /boot              | XBOOTLDR, better ext4 to avoid subtle issues for boot loading |
>| 5*| UEFI | EF00 |   1G | fat32! | /boot/efi          | efi suggests fat formatting |
>| 5*| BIOS | EF02 |   1M |   --   |         --         | bios no need formatting |
>| 6 | CODE | 8300 |  32G | f2fs   | /home/yo_user/code | compression attribute enabled, compress extensions: asm,c,cpp,txt,js ... |
>| 7 | DATA | 8300 | 256G | xfs    | /home/yo_user/data | assets |
>| 8 | HOME | 8302 | full | nilfs2 | /home              | Linux home/|

- 5\* - either UEFI or BIOS based on your system

- if there are leftovers of previous partition signatures wipe them all

>
> - ~# lsblk -f~
> - ~# wipefs -a /dev/partitions~
>

#### Pre

- making

```bash
# mkswap -L SWAP $yo_deswap
# mkfs.ext4 -L ROOT $yo_deroot
# mkfs.ext4 -L BOOT $yo_deboot
# mkfs.nilfs2 -L HOME $yo_dehome
# [ -n "${yo_uefi}" ] && mkfs.fat -n UEFI -F 32 ${yo_deuefi}
```

- mounting

```
# swapon -L SWAP
# mount -L ROOT /mnt
# mount -L BOOT --mkdir /mnt/boot
# mount -L HOME --mkdir /mnt/home
# [ -n "${yo_uefi}" ] && mount -L UEFI --mkdir /mnt/boot/efi
```

#### Pacstrap

```bash
# mkdir /mnt/etc
# echo "KEYMAP=$yo_keys" > /mnt/etc/vconsole.conf
# pacstrap -K /mnt base base-devel linux linux-firmware neovim networkmanager grub ${yo_uefi}
# arch-chroot /mnt
# ln -s /usr/bin/nvim /usr/bin/vi
# ln -sf /usr/share/zoneinfo/$yo_zone /etc/localtime
# hwclock --systohc
# echo "$yo_lang UTF-8" >> /etc/locale.gen
# locale-gen
# echo "LANG=${yo_lang}" > /etc/locale.conf
# echo "${yo_host}" > /etc/hostname
# [ -z "${yo_uefi}" ] && grub-install --target=i386-pc $yo_device
# [ -n "${yo_uefi}" ] && grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg
# useradd -m $yo_user
# usermod -aG wheel $yo_user
# visudo
# passwd
# passwd $yo_user
# mkdir /root/past
# su - $yo_user
$ mkdir {code,data}
$ exit
# exit
```

#### Post

- make file systems

```bash
# mkfs.btrfs -L PAST $yo_depast
# mkfs.xfs -L DATA $yo_dedata
# mkfs.f2fs -l CODE -O extra_attr,compression $yo_decode
```

- mounting

```bash
# mount -L PAST -o compress=zstd:8 --mkdir /mnt/root/past
# mount -L DATA /mnt/home/$yo_user/data
# mount -L CODE -o $yo_compress /mnt/home/$yo_user/code
# chown -R 1000:1000 /mnt/home/$yo_user
```

- generate file system table (check if `fstab` generated correctly) and rebooting

```bash
# genfstab -U /mnt > /mnt/etc/fstab
# umount -R /mnt
# reboot
```

#### Timeshift

```bash
$ sudo systemctl enable --now NetworkManager.service
$ sudo pacman -S timeshift btrfs-progs dosfstools f2fs-tools e2fsprogs nilfs-utils xfsprogs htop
$ sudo timeshift --help
$ sudo lsblk -o LABEL,UUID | grep PAST > /tmp/past.uuid
$ sudo vi -p /etc/timeshift/timeshift.json /tmp/past.uuid
```

- update config with backup_device_uuid PAST partition uuid, add to exclude list:
> - /root/\*\*
> - /root/past/\*\*
> - /home/\*\*
> - /home/~~USER~~/data/\*\*
> - /home/~~USER~~/code/\*\*

- grub should be on BOOT partition (device partition ended with 4)

```bash
$ sudo timeshift --create --comment "init"
$ sudo timeshift --restore
```

- check if it actually all working after restore.

###### each folder MAY contain README with additional materials
