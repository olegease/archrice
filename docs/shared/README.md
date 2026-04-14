## SHARED

#### Theme

```bash
$ sudo pacman -S gnome-themes-extra
$ cp $ar_path/source/configs/shared/gtk3/settings.ini ~/.config/gtk-3.0/
$ cp $ar_path/source/configs/shared/gtk4/settings.ini ~/.config/gtk-4.0/
```

#### CODING

```bash
$ sudo pacman -S boost code gdb git cmake ninja nasm nodejs n{p,v}m open{code,ssh} tree
```

#### Source Control
> generating ssh key

```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ed25519
```

> generating gpg key, use RSA 4096 bits, use same email as git server hosting account

```bash
$ gpg --full-generate-key
$ gpg --list-secret-keys --keyid-format LONG
```

> git configuration

```bash
$ git config --global user.email "your-mail"
$ git config --global user.name "yours-name"
$ git config --global user.signingkey <GPG KEY ID>
$ git config --global commit.gpgsign true
```

#### Code Editor
> neovim configuration

```bash
$ mkdir -p ~/.config/nvim
$ cp $ar_path/source/configs/shared/neovim/init.lua ~/.config/nvim/
```

#### LLM Helper
> opencode configuration

