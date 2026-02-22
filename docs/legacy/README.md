## LEGACY
> x11

#### Display Manager
> xdm-archlinux

```bash
$ sudo pacman -S xorg-server xdm-archlinux
```

#### Window Manager
> herbstluftwm

```bash
$ sudo pacman -S alacritty herbstluftwm
$ cd
$ echo "export TERMINAL=alacritty" > .xsession
$ echo "exec herbstluftwm" >> .xsession
$ chmod +x .xsession
$ sudo systemctl enable --now xdm-archlinux.service
```

- alt-enter to open terminal emulator, and configure window manager

```bash
$ cd
$ mkdir -p .config/herbstluftwm
$ cp /etc/xgd/herbstluftwm/autostart .config/herbstluftwm
$ vi .config/herbstluftwm/autostart
```

- change default mod key from alt to super key

#### Terminal Emulator
> alacritty (configuration)
