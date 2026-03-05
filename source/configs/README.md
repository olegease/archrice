## CONFIGS
> configurations for packages, depends where package is used placed under legacy, modern, or shared subdirectory with package name in arch linux repository subdirectory and with filename same as package config filename are expecting

File `path.txt` contains path list where configs should be copied from (source/configs) to destination system path:

- `$` user
- `#` root: need copy with sudo

Currently added `package-name (type): files`:

- neovim (shared): init.lua
- kitty (modern): kitty.conf
- hyprland (modern): hyprland.conf
- hyprpaper (modern): hyprpaper.conf
- greetd (modern): config.toml
- nwg-hello (modern): nwg-hello.css nwg-hello.json hyprland.conf
- gtk3 (shared): settings.ini
- gtk4 (shared): settings.ini
- herbstluftwm (legacy): autostart
- waybar (modern): config.jsonc style.css
