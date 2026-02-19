## LEGACY
> x11

#### Device Manager
> xdm-archlinux

```bash
$ sudo pacman -S xorg-server xdm-archlinux
$ sudo systemctl enable xdm-archlinux.service
```

#### Window Manager
> herbstluftwm

```bash
$ echo "exec /usr/bin/herbstluftwm" > ~/.xsession
$ sudo pacman -S xterm herbstluftwm
$ sudo systemctl start xdm-archlinux.service
```

- alt-enter to open terminal emulator (xterm by default)

```bash
$ cd
$ mkdir -p .config/herbstluftwm
$ cp /etc/xgd/herbstluftwm/autostart .config/herbstluftwm
$ vi .config/herbstluftwm/autostart
```

- change default mod key from alt to super key

#### Terminal Emulator
> alacritty
