## SHARED

#### Theme

```bash
$ sudo pacman -S gnome-themes-extra
$ cp $ar_path/source/configs/shared/gtk3/settings.ini ~/.config/gtk-3.0/
$ cp $ar_path/source/configs/shared/gtk4/settings.ini ~/.config/gtk-4.0/
```

#### CODING

```bash
$ sudo pacman -S git cmake ninja nasm nodejs n{p,v}m open{code,ssh}
$ gh auth login
```

#### Source Control
> git configuration

```bash
$ git config --global user.email "your-mail"
$ git config --global user.name "yours-name"
```

#### Code Editor
> neovim configuration

```bash
$ mkdir -p ~/.config/nvim
$ cp $ar_path/source/configs/shared/neovim/init.lua ~/.config/nvim/
```

#### LLM Helper
> opencode configuration

