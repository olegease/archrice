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

- allow only hyprland session
```bash
$ sudo mkdir /usr/share/hyprland-session
$ sudo ln -s /usr/share/wayland-sessions/hyprland.desktop /usr/share/hyprland-session/hyprland.desktop
```

- configure nwg-hello appearance (replace all sessions path with only `/usr/share/hyprland-session`)
```bash
$ cd /etc/nwg-hello/
$ sudo cp nwg-hello-default.json nwg-hello.json
$ sudo cp nwg-hello-default.css nwg-hello.css
$ sudo vi -p nwg-hello.json nwg-hello.css
```

```bash
$ sudo systemctl enable --now greetd.service
```

#### Window manager
> hyprland configuration

#### Terminal emulator
> kitty configuration
