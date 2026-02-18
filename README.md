# ARCHRICE

> In progress...

## Installation

#### Export and preparation

```bash
# setfont ter-128b
# timedatectl
# ping ping.archlinux.org
```

- TODO add wifi and other connections link

Examples:
- user: john
- host: local
- locale: en_US.UTF-8
- keys: us
- device: /dev/sda | /dev/vda | /dev/nvme0n1 (if ends on digit add `p` to partition exports before 1-8 digit )
- zone: Atlantic/Madeira
- uefi: efibootmgr if UEFI else empty

```bash
# [ -d /sys/firmware/efi ] && export yo_uefi="efibootmgr"
# export yo_user=your-user-name
# export yo_host=your-host-name
# export yo_zone=your-zone-name
# export yo_keys=your-keymap
# export yo_lang=your-locale
# export yo_device=your-device-name
# export yo_deswap=${yo_device}1
# export yo_deroot=${yo_device}2
# export yo_deboot=${yo_device}3
# export yo_depast=${yo_device}4
# export yo_dedata=${yo_device}5
# export yo_decode=${yo_device}6
# export yo_detemp=${yo_device}7
# export yo_dehome=${yo_device}8
```

#### Partition
> Completely Format DISK (cfdisk)

- Create GPT partition of linux swap and wipe it

```bash
# cfdisk ${yo_device}
# mkswap ${yo_deswap}
# wipefs ${yo_deswap}
# gdisk ${yo_device}
```

- Run partitioning again but now create proper partitions

>| # | NAME | CODE | SIZE | SYSTEM |        PATH        |
>|---|------|------|------|--------|--------------------|
>| 1 | SWAP | 8200 |  15G |   --   |         --         |
>| 2 | ROOT | 8304 |  48G | ext4   | /                  |
>| 3*| BOOT | EF00 |   1G | fat32  | /boot/efi          |
>| 3*| BOOT | EF02 |   1M |   --   |         --         |
>| 4 | PAST | 8300 |  80G | btrfs  | /past              |
>| 5 | DATA | 8300 | 256G | xfs    | /home/yo_user/data |
>| 6 | CODE | 8300 |  24G | f2fs   | /home/yo_user/code |
>| 7 | TEMP | 8300 |   8G | ext2   | /home/yo_user/temp |
>| 8 | HOME | 8302 | else | nilfs2 | /home              |

- 3\* - either UEFI or BIOS based on your system

```bash
# mkswap -L SWAP ${yo_deswap}
# mkfs.ext4 -L ROOT ${yo_deroot}
# [ -n "${yo_uefi}" ] && mkfs.fat -L BOOT -F 32 ${yo_deboot}
# mkfs.nilfs2 -L HOME ${yo_dehome}
# swapon -L SWAP
# mount -L ROOT /mnt
# [ -n "${yo_uefi}" ] && mount -L BOOT --mkdir /mnt/boot/efi
# mount -L HOME --mkdir /mnt/home
```

#### Pacstrap

```bash
# echo "KEYMAP=${yo_keys}" > /mnt/etc/vconsole.conf
# pacstrap -K /mnt base base-devel linux linux-firmware neovim networkmanager grub ${yo_uefi}
# arch-chroot /mnt
# ln -s /usr/bin/nvim /usr/bin/vi
# ln -sf /usr/share/zoneinfo/${yo_zone} /etc/localtime
# echo "${yo_lang} UTF-8" >> /etc/locale.gen
# locale-gen
# echo "LANG=${yo_lang}" > /etc/locale.conf
# echo "${yo_host}" > /etc/hostname
# [ -z "${yo_uefi}" ] && grub-install --target=i386-pc ${yo_device}
# [ -n "${yo_uefi}" ] && grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg
# useradd -m ${yo_user}
# usermod -aG wheel ${yo_user}
# visudo
# passwd
# passwd ${yo_user}
# su - ${yo_user}
$ mkdir {data,code,temp}
$ exit
# exit
```

#### Post

- make file systems

```bash
# mkfs.btrfs -L PAST ${yo_depast}
# mkfs.xfs -L DATA ${yo_dedata}
# mkfs.f2fs -l CODE -O extra_attr,compression ${yo_decode}
# mkfs.ext2 -L TEMP ${yo_detemp}
```

- mounting

```bash
# mount -L PAST -o compress=zstd:8 --mkdir /mnt/past
# mount -L DATA /mnt/home/${yo_user}/data
# mount -L CODE -o compress_extension=hxx /mnt/home/${yo_user}/code
# mount -L TEMP /mnt/home/${yo_user}/temp
# chown -R 1000:1000 /mnt/home/${yo_user}
# genfstab -U /mnt > /mnt/etc/fstab
# reboot
```

#### Timeshift

```bash
$ sudo systemctl enable --now NetworkManager
$ sudo pacman -S timeshift
$ sudo timeshift --check
$ sudo vi /etc/timeshift/timeshift.json
```

- update config with backup_device_uuid PAST partition uuid, add to exclude list:
  - /root/\*\*
  - /past/\*\*
  - /home/\*\*
  - /home/${yo_user}/\*\*
  - /home/${yo_user}/data/\*\*
  - /home/${yo_user}/code/\*\*,
  - /home/${yo_user}/temp/\*\*,

```bash
$ sudo timeshift --create --comment "init"
$ sudo timeshift --restore
```

- check if it actually all working after restore.

###### each folder MAY contain README with additional materials
