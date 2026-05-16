## LEGACY
> x11

#### Display Manager
> xdm-archlinux

```bash
$ sudo pacman -S xorg-server xdm-archlinux
```

#### Window Manager
> herbstluftwm (default configuration at `/etc/xgd/herbstluftwm/autostart`)

```bash
$ sudo pacman -S alacritty herbstluftwm feh
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
$ cp $ar_path/source/configs/legacy/herbstluftwm/autostart .config/herbstluftwm/
$ chmod +x .config/herbstluftwm/autostart
```

#### Terminal Emulator
> alacritty (configuration)


