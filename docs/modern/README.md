## MODERN
> wayland

#### Display Manager
> nwg-hello (needs wayland compositor so tight them together) configuration

```bash
$ sudo pacman -S hyprland kitty nwg-hello
```

- edit `command = "start-hyprland -- -c /etc/nwg-hello/hyprland.conf`
```bash
$ sudo vi /etc/greetd/config.toml
```

- configure nwg-hello appearance
```bash
$ cd /etc/nwg-hello/
$ cp nwg-hello-default.json nwg-hello.json
$ sudo vi nwg-hello-default.json
```

```bash
$ sudo systemctl enable --now greetd.service
```

#### Window manager
> hyprland configuration

#### Terminal emulator
> kitty configuration
