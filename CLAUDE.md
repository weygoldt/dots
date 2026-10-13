# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal Arch Linux dotfiles managed with **GNU Stow**. Each top-level directory is a Stow "package": its internal tree mirrors the desired layout under `$HOME`, and `stow` symlinks files from `~/.dotfiles/<package>/...` to their target locations (typically under `~/.config/...`). The repo is checked out at `~/.dotfiles`; nothing here is meant to live anywhere else.

## Common commands

Everything is driven by the `Makefile` at the repo root. The current working directory must be `~/.dotfiles` when running these.

- `make all` — stow every generic package plus the host-specific overrides for the current machine (initial setup on a fresh system).
- `make <package>` — stow a single package, e.g. `make nvim`, `make hypr`, `make zsh`.
- `make update` — re-stow everything (`stow -R`); use this after adding/removing files inside a package so symlinks reflect the new tree.
- `make clean` — unstow everything (`stow -D`); leaves the repo intact but removes the symlinks from `$HOME`.
- `make check` — dry run of `make update`; shows what stow would change without touching `$HOME`.

Submodule note: `nvim/.config/nvim` is a git submodule pointing at `weygoldt/nvimdots`. After a fresh clone, run `git submodule update --init --recursive` before `make nvim`.

## Host-specific overrides

Some configs differ between machines. The convention is `<base>-home/` and `<base>-work/` packages alongside the generic `<base>/`:

- Generic package (e.g. `hypr/`) holds shared config.
- `hypr-home/`, `hypr-work/` hold only the files that differ (e.g. `monitors.lua`).

The `Makefile` picks the right override set by matching `uname -n` against two hardcoded hostnames at the top of the file:

- `HOME_HOSTNAME := archlinux`
- `WORK_HOSTNAME := polarbear`

Only directories ending in `-home` or `-work` are treated as overrides. If you add a new host or rename a machine, update the Makefile constants — there is no auto-detection beyond hostname match. The same pattern is used for `git-home`/`git-work` and `ssh-home`/`ssh-work`.

## Stow ignore rules

`.stow-local-ignore` excludes meta-directories (`.scripts/`, `.system/`, `.assets/`, `.git`, `*.org`) from symlinking. These live at the repo root and are *not* stowed:

- `.scripts/` — backup, sync, and update helper scripts (not part of `$HOME` config).
- `.system/` — Arch install / maintain / backup procedures and notes.
- `.assets/` — screenshots and images referenced by the README.

When adding new top-level directories, decide whether they should be a Stow package (mirror a `$HOME` subtree inside them) or a meta-directory (add to `.stow-local-ignore`).

## When editing configs

- Files in `~/.config/...` on this system are symlinks into this repo. Editing either side edits the source; there is no separate "deploy" step after editing.
- Adding a *new* file inside an existing package generally requires `make update` (or `make <package>`) so Stow creates the new symlink. Editing an existing tracked file does not.
- The `hypr` package is the active example: `hyprland.lua` (plus the modules it `require`s) is the shared config and machine-specific monitor layout lives in `hypr-home/monitors.lua` or `hypr-work/monitors.lua`.
- Hyprland runs a **Lua config**: legacy `hyprctl keyword ...` and `hyprctl dispatch <name> <args>` fail. Use `hyprctl eval '<lua>'` and `hyprctl dispatch 'hl.dsp.focus({ workspace = "e+1" })'` in scripts, aliases and waybar.
- The `hypr` package is shared with the work machine: per-host changes belong in `hypr-home`/`hypr-work`.
- waybar icons are Nerd Font private-use glyphs that are easy to lose when rewriting files; verify them after edits.
