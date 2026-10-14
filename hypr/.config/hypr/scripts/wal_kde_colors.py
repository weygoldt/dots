#!/usr/bin/env python3
"""Build a KDE colour scheme (.colors) from pywal for qt6ct and KDE apps.

Uses an existing scheme (e.g. BreezeDark.colors) as the template and swaps
its colours for a wallpaper-derived palette: dark backgrounds tinted with the
wallpaper, light readable text, and one pastel accent for selection/focus.
Semantic colours (negative/neutral/positive) keep their template values.

usage: wal_kde_colors.py COLORS_JSON TEMPLATE_COLORS OUT_COLORS
"""

import colorsys
import json
import os
import re
import sys
from pathlib import Path

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from wal_waybar_css import contrast, darken_until, hex_to_rgb, pastel  # noqa: E402


def shade(rgb, dl):
    """Shift lightness by dl (HLS)."""
    h, l, s = colorsys.rgb_to_hls(*rgb)
    return colorsys.hls_to_rgb(h, min(max(l + dl, 0), 1), s)


def readable_fg(rgb, bg, target=10.0):
    """Lighten a (wal foreground) colour until it reads well on bg."""
    h, l, s = colorsys.rgb_to_hls(*rgb)
    s = min(s, 0.25)
    while l < 0.97 and contrast(colorsys.hls_to_rgb(h, l, s), bg) < target:
        l += 0.01
    return colorsys.hls_to_rgb(h, l, s)


def kde(rgb):
    return ",".join(str(round(c * 255)) for c in rgb)


def palette(wal):
    c, sp = wal["colors"], wal["special"]
    window = darken_until(hex_to_rgb(sp["background"]), max_lum=0.012)
    view = shade(window, -0.02)  # content areas a touch deeper
    button = shade(window, 0.05)
    header = shade(window, 0.02)
    fg = readable_fg(hex_to_rgb(sp["foreground"]), window)
    inactive = shade(fg, -0.30)
    accent = pastel(hex_to_rgb(c["color4"]), window)  # same source as the bar's "pine"
    hover = pastel(hex_to_rgb(c["color6"]), window)
    return {
        "window": window, "view": view, "button": button, "header": header,
        "fg": fg, "inactive": inactive, "accent": accent, "hover": hover,
    }


def main(colors_json, template, out_path):
    p = palette(json.loads(Path(colors_json).read_text()))

    # per section: background, alternate background
    bgs = {
        "Colors:Window": (p["window"], shade(p["window"], 0.03)),
        "Colors:View": (p["view"], shade(p["view"], 0.03)),
        "Colors:Button": (p["button"], shade(p["button"], 0.03)),
        "Colors:Header": (p["header"], shade(p["header"], 0.03)),
        "Colors:Header][Inactive": (p["window"], shade(p["window"], 0.03)),
        "Colors:Tooltip": (p["window"], shade(p["window"], 0.03)),
        "Colors:Complementary": (p["window"], shade(p["window"], 0.03)),
        "Colors:Selection": (p["accent"], shade(p["accent"], -0.05)),
    }

    out, section = [], None
    for line in Path(template).read_text().splitlines():
        m = re.match(r"^\[(.*)\]$", line)
        if m:
            section = m.group(1)
        elif "=" in line and section in bgs:
            key = line.split("=", 1)[0]
            bg, alt = bgs[section]
            on_accent = section == "Colors:Selection"
            fg = p["window"] if on_accent else p["fg"]
            val = {
                "BackgroundNormal": bg,
                "BackgroundAlternate": alt,
                "ForegroundNormal": fg,
                "ForegroundActive": fg if on_accent else p["accent"],
                "ForegroundInactive": shade(fg, 0.25) if on_accent else p["inactive"],
                "ForegroundLink": p["window"] if on_accent else p["accent"],
                "ForegroundVisited": p["window"] if on_accent else p["hover"],
                "DecorationFocus": p["accent"],
                "DecorationHover": p["hover"],
            }.get(key)
            if val is not None:
                line = f"{key}={kde(val)}"
        elif section == "General" and line.startswith("Name="):
            line = "Name=Wal"
        elif section == "General" and line.startswith("ColorScheme="):
            line = "ColorScheme=Wal"
        elif section == "WM" and "=" in line:
            key = line.split("=", 1)[0]
            val = {
                "activeBackground": p["header"], "inactiveBackground": p["window"],
                "activeForeground": p["fg"], "inactiveForeground": p["inactive"],
                "activeBlend": p["fg"], "inactiveBlend": p["inactive"],
            }.get(key)
            if val is not None:
                line = f"{key}={kde(val)}"
        out.append(line)

    Path(out_path).parent.mkdir(parents=True, exist_ok=True)
    Path(out_path).write_text("\n".join(out) + "\n")

    # Hex accent for callers (Hyprland border)
    print("#" + "".join(f"{round(x * 255):02x}" for x in p["accent"]))


if __name__ == "__main__":
    main(*sys.argv[1:4])
