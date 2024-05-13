# Welcome to my linux dotfiles

**UPDATE:** I moved from managing my config via a bare git repository to GNU
stow. This essentially symlinks all config files to where they belong while the
original files remain at `~/.dotfiles`. The big advantage is, that I can
dynamically symlink - and unlink - just parts of my config. When working on a
remote server for example, I can just link my neovim and tmux config, without
having to clutter the .config directory with my window manager configurations
as well. The different config files between my home and work machine for
example are automatically managed by my Makefile.

This repository includes my personal configuration files for my Arch linux
workstation. It is designed to be minimal, bleeding edge, but still beautiful.
Everything is configurable by text files. Most files can be used on
other GNU/Linux distributions as well but some scripts only work on Arch-based
systems.

- **Distro**: [Arch Linux](https://archlinux.org/)
- **WM**: [Hyprland](https://hyprland.org/)
- **Panel**: [Waybar](https://github.com/Alexays/Waybar)
- **Terminal**: [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Shell**: [Zsh](https://www.zsh.org/) w/ [starship](https://starship.rs/) promt
- **Launcher**: [Wofi](https://hg.sr.ht/~scoopta/wofi)
- **Notifications**: [Mako](https://github.com/emersion/mako)
- **Wallpapers**: [Swww](https://github.com/Horus645/swww)
- **Code editor**: [Neovim](https://github.com/dam9000/kickstart-modular.nvim)
- **Notes**: [Obsidian](https://obsidian.md/)
- **Browser**: Firefox w/ [VimiumFF](https://github.com/philc/vimium)

**Screenshots**

![Screenshots](.assets/showcase.png)

## Why

I use Arch Linux because of multiple reasons:

1. It is **easy** and fast to install using the built in `archinstall` script.
2. It provides and extremely **lightweight** base to build my workspace on top of it.
3. I am _forced_ to use (and hence **learn**) up to date software.

I switched to Wayland because it will slowly replace Xorg. I use a window
manager because my daily work resolves around editing text files in the
terminal. Beeing forced to navigate exclusively by the keyboard makes
navigation faster and prevents wrist problems. I chose Hyprland because it was
easy to install, configure and looks extremely nice.

## The how

To install the base system, I simpy use the
[`archinstall`](https://wiki.archlinux.org/title/archinstall) script with the
`hyprland` and `plasma` (for fallback) profiles. To install the graphical
frontend, I just follow the awesome tutorial on the [hyprland
wiki](https://wiki.hyprland.org/Getting-Started/Installation/). Now to
initialize my dotfiles on a new system, I clone this repository like this:

```sh
rm -rf $HOME/.dotfiles
git clone https://github.com/weygoldt/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
make all
```

Do not forget to make a history file for zsh wherever the path to the file is specified in the current version of the .zshrc:

```sh
touch $HOME/.config/zsh/zsh_history
```

## Included

Most of my dotfiles are simple configuration files of shells, terminals, etc.
But there are also some [scripts](scripts) that I use to automate some tasks as
well as document the packages I need on a system to make the migration to new
systems faster. In addition, I document how I [install](system/install-arch),
[maintain](system/maintain-arch) and [backup](system/backup-arch) my
workstation.
