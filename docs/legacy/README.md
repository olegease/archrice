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
$ sudo pacman -S alacritty herbstluftwm firefox lollypop feh
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
$ cp code/archrice/source/configs/legacy/herbstluftwm/autostart .config/herbstluftwm/
```

- change default mod key from alt to super key

#### Terminal Emulator
> alacritty (configuration)

#### Music Player
> lollypop


