# DOCS
> TODO when root [README](../README.md) finalized move it contents here

Do not use packages that have QT dependancies

- legacy: x11 related, opengl, lightweight
- modern: wayland related, vulkan extensible
- shared: used in both - legacy and modern

## Essential

```bash
$ sudo pacman -S chromium archlinux-wallpaper
```

## Pacman
> pacman configuration

```bash
$ sudo cp $ar_path/source/configs/shared/pacman/pacman.conf /etc/
```

## Reflector

```bash
$ sudo pacman -S reflector
$ sudo cp $ar_path/source/configs/shared/reflector/reflector.conf /etc/xdg/reflector/
$ sudo systemctl enable --now reflector.timer
```

## Fonts

```bash
$ sudo pacman -S adobe-source-{serif,sans,code-pro}-fonts noto-fonts{,-emoji}
```

## Audio

```bash
$ pipewire-{alsa,pulse,jack} wireplumber playerctl
$ systemctl --user enable --now pipewire pipewire-pulse wireplumber
$ wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.50
```
