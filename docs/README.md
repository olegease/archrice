# DOCS
> TODO when root [README](../README.md) finalized move it contents here

Do not use packages that have QT dependancies

- legacy: x11 related, opengl, lightweight
- modern: wayland related, vulkan extensible
- shared: used in both - legacy and modern

## Essential

```bash
$ sudo pacman -S man-db man-pages chromium archlinux-wallpaper unzip
```

## Fonts

```bash
$ sudo pacman -S adobe-source-{serif,sans,code-pro}-fonts

```

## Audio

```bash
$ pipewire-{alsa,pulse,jack} wireplumber
$ systemctl --user enable --now pipewire pipewire-pulse wireplumber
$ wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.50
```
