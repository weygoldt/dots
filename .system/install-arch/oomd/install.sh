#!/usr/bin/env bash
# Install the systemd-oomd drop-ins and enable oomd (they live in /etc, so they
# can't be stowed). Arch ships no ManagedOOM* defaults, so oomd without these
# monitors nothing and a runaway build still freezes the whole system.
set -euo pipefail
cd "$(dirname "$0")"

sudo install -Dm644 root-slice.conf /etc/systemd/system/-.slice.d/10-oomd.conf
sudo install -Dm644 user-service.conf /etc/systemd/system/user@.service.d/10-oomd.conf
sudo systemctl daemon-reload
sudo systemctl enable --now systemd-oomd.service
oomctl
