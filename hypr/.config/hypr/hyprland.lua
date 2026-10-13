-- Hyprland config (Lua, since 0.55).
-- See: https://wiki.hypr.land/Configuring/Start/

----------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------

local HOME = os.getenv("HOME")
local mainMod = "SUPER"
local scriptsDir = HOME .. "/.config/hypr/scripts"
local hyprDir = HOME .. "/.config/hypr"
local wallpapersDir = HOME .. "/Pictures/wallpapers"
local windowOpacity = 0.75

-- Desktop environment scripts
local powermenu = scriptsDir .. "/powermenu"
local volume = scriptsDir .. "/volume"
local backlight = scriptsDir .. "/brightness"
local screenshot = scriptsDir .. "/screenshot"
local lock = scriptsDir .. "/lock"
local colorpicker = "hyprpicker --autocopy"
local wofi_beats = scriptsDir .. "/wofi-beats"
local wallpaper = scriptsDir .. "/set_wallpaper.py"
local tmux_picker = scriptsDir .. "/tmux_picker.sh"

-- Default apps
local term = "kitty"
local files = scriptsDir .. "/files" -- Dolphin
local browser = scriptsDir .. "/browser" -- clean profile in SFW mode
local editor = "kitty --class Nvim --title Nvim -e nvim"
local music = "spotify --ozone-platform=wayland --enable-features=UseOzonePlatform"
local audio = "pavucontrol"
local mail = "thunderbird"

-- Re-exported so other modules can see them via require("hyprland") if needed.
_G.HYPR = {
	HOME = HOME,
	mainMod = mainMod,
	scriptsDir = scriptsDir,
	hyprDir = hyprDir,
	wallpapersDir = wallpapersDir,
	windowOpacity = windowOpacity,
	powermenu = powermenu,
	volume = volume,
	backlight = backlight,
	screenshot = screenshot,
	lock = lock,
	colorpicker = colorpicker,
	wofi_beats = wofi_beats,
	wallpaper = wallpaper,
	tmux_picker = tmux_picker,
	term = term,
	files = files,
	browser = browser,
	editor = editor,
	music = music,
	audio = audio,
	mail = mail,
}

----------------------------------------------------------------------
-- Environment variables
----------------------------------------------------------------------

-- Nvidia
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")

-- Toolkit / desktop integration
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct") -- install the patched qt6ct-kde from AUR
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XDG_MENU_PREFIX", "arch-") -- needs archlinux-xdg-menu for "open in dolphin"
-- hl.env("XDG_MENU_PREFIX", "plasma-")

----------------------------------------------------------------------
-- Autostart
----------------------------------------------------------------------

hl.on("hyprland.start", function()
	-- xdg-desktop-portal reset (re-enable if portal issues return)
	-- hl.exec_cmd(scriptsDir .. "/resetxdgportal.sh")
	-- hl.exec_cmd("xdg-desktop-portal-hyprland")
	-- hl.exec_cmd("xdg-desktop-portal")

	hl.exec_cmd("/usr/lib/pam_kwallet_init")
	hl.exec_cmd("kwalletd6")
	hl.exec_cmd("kded6")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hyprctl setcursor capitaine-cursors-light 24")
	hl.exec_cmd("nwg-look -a")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd(scriptsDir .. "/statusbar")
	-- the systemd unit, not a bare `swaync`: D-Bus would start the unit as well
	-- (first notification) and the second copy keeps failing
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user start swaync")
	hl.exec_cmd("hypridle") -- idle dim / lock / screen off / suspend: hypridle.conf
	hl.exec_cmd(scriptsDir .. "/battery-notify") -- no-op without a battery
	hl.exec_cmd("kbuildsycoca6")
	hl.exec_cmd("clipse -listen")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("python " .. wallpaper .. " --path " .. wallpapersDir)
end)

----------------------------------------------------------------------
-- Modules (each require is its own Lua scope; one failing doesn't
-- take the others down — see https://wiki.hypr.land/Configuring/Start/)
----------------------------------------------------------------------

require("monitors") -- per-host, from hypr-home/ or hypr-work/
require("settings")
require("workspacerules")
require("windowrules")
require("layerrules")
require("binds")
