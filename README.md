# Welcome to my linux dotfiles

My config is managed with GNU stow. This symlinks all config files to where
they belong while the original files remain at `~/.dotfiles`. The big advantage
is that I can dynamically symlink - and unlink - just parts of my config. When working on a
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
- **Shell**: [Zsh](https://www.zsh.org/) w/ [starship](https://starship.rs/) prompt
- **Launcher**: [sway-launcher-desktop](https://github.com/Biont/sway-launcher-desktop) in Kitty, [Wofi](https://hg.sr.ht/~scoopta/wofi) for menus
- **Notifications**: [SwayNotificationCenter](https://github.com/ErikReider/SwayNotificationCenter)
- **Wallpapers**: [awww](https://archlinux.org/packages/?name=awww) (formerly swww)
- **Code editor**: [Neovim](https://neovim.io/), based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (separate [nvimdots](https://github.com/weygoldt/nvimdots) submodule)
- **Browser**: [Firefox](https://www.mozilla.org/firefox/) w/ [Vimium](https://github.com/philc/vimium)

**Screenshots**

![Screenshots](.assets/showcase.png)

## Why

I use Arch Linux because of multiple reasons:

1. It is **easy** and fast to install using the built in `archinstall` script.
2. It provides an extremely **lightweight** base to build my workspace on top of it.
3. I am _forced_ to use (and hence **learn**) up to date software.

I switched to Wayland because it will slowly replace Xorg. I use a window
manager because my daily work revolves around editing text files in the
terminal. Being forced to navigate exclusively by the keyboard makes
navigation faster and prevents wrist problems. I chose Hyprland because it was
easy to install, configure and looks extremely nice.

## The how

To install the base system, I simply use the
[`archinstall`](https://wiki.archlinux.org/title/archinstall) script with the
`hyprland` and `plasma` (for fallback) profiles. To install the graphical
frontend, I just follow the awesome tutorial on the [hyprland
wiki](https://wiki.hypr.land/Getting-Started/Installation/). Now to
initialize my dotfiles on a new system, I clone this repository like this:

```sh
rm -rf $HOME/.dotfiles
git clone --recurse-submodules git@github.com:weygoldt/dots.git $HOME/.dotfiles
cd $HOME/.dotfiles
make all
```

`make all` stows every package plus the overrides for the current machine.
Configs that differ between my home and work machine live in `<name>-home/` and
`<name>-work/` packages (e.g. `hypr-home/` only holds the monitor layout); the
Makefile picks the right set by hostname.

Hyprland uses the new Lua config (`hyprland.lua`). Legacy `hyprctl keyword` and
`hyprctl dispatch <name> <args>` calls do not work with it, so scripts use
`hyprctl eval '<lua>'` or `hyprctl dispatch 'hl.dsp...'` instead.

## Included

Most of my dotfiles are simple configuration files of shells, terminals, etc.
But there are also some [scripts](.scripts) that I use to automate some tasks
(backups, syncing, updates) as well as document the packages I need on a system
to make the migration to new systems faster. In addition, I document how I
[backup](.system/backup-arch) my workstation.

## TODO

- [ ] Fix the formatting of the swaync control panel
- [ ] Create a standardized position for the current wallpaper
- [ ] Fix the notification icons of the volume, brightness, screenshot and
      screen2gif scripts, they still point to the old `hypr/mako/icons` dir

- [x] Fix the formatting of wlogout

