#!/usr/bin/env bash
# Install the pacman hooks in this directory (pacman reads hooks from /etc,
# so they can't be stowed). Re-run after editing a hook or its script.
set -euo pipefail
cd "$(dirname "$0")"

sudo install -Dm644 -t /etc/pacman.d/hooks ./*.hook
sudo install -Dm755 -t /etc/pacman.d/hooks.bin qt-private-api-check
echo "Installed: $(ls ./*.hook | xargs -n1 basename | tr '\n' ' ')"
