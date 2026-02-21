## MODERN
> wayland

#### Display Manager
> greetd-regreet (regreet needs wayland compositor so tight them together)

```bash
$ sudo pacman -S hyprland kitty greetd-regreet
$ echo "exec-once = regreet; hyprctl dispatch exit" | sudo tee /etc/config/hypr.conf

```

- edit `command = "start-hyprland -- -c /etc/greetd/hypr.conf`
```bash
$ sudo vi /etc/greetd/config.toml
```

- configure regreet appearance
```bash
$ sudo vi /etc/greetd/regreet.toml
```

```bash
$ sudo systemctl start greetd.service
```

#### Window manager
> hyprland configuration

#### Terminal emulator
> kitty configuration
