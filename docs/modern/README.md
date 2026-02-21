## MODERN
> wayland

#### Window manager
> hyprland

```bash
$ sudo pacman -S hyprland kitty greetd
$ sudo vi /etc/greetd/config.toml
```

- edit `command = "agreety --cmd start-hyprland"`

```bash
$ sudo systemctl enable --now greetd.service
```

#### Display manager
> ???
