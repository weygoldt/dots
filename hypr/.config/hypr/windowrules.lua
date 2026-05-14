-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Named rules are evaluated before anonymous ones (per the wiki).

local H = _G.HYPR
local OP = tostring(H.windowOpacity)

----------------------------------------------------------------------
-- Named: floating dialogs
----------------------------------------------------------------------

hl.window_rule({
	name = "polkit-kde-auth",
	match = { class = "org.kde.polkit-kde-authentication-agent-1" },
	animation = "popin",
	float = true,
	size = { "monitor_w*0.3", "monitor_h*0.2" },
	center = true,
})

hl.window_rule({
	name = "onepassword",
	match = { class = "1Password" },
	animation = "popin",
	float = true,
})

hl.window_rule({
	name = "sway-launcher",
	match = { class = "Launcher" },
	float = true,
	size = { "monitor_w*0.2", "monitor_h*0.2" },
	center = true,
})

----------------------------------------------------------------------
-- Named: matplotlib figure windows
-- (initial_class + initial_title narrows to actual figures, not all
--  python3 GUIs)
----------------------------------------------------------------------

hl.window_rule({
	name = "float-matplotlib",
	match = { initial_class = "python3", initial_title = "Figure.*" },
	float = true,
	no_max_size = true,
})

----------------------------------------------------------------------
-- Named: smart-gaps companion rules
----------------------------------------------------------------------

hl.window_rule({
	name = "no-gaps-wtv1",
	match = { float = false, workspace = "w[tv1]s[false]" },
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	name = "no-gaps-f1",
	match = { float = false, workspace = "f[1]s[false]" },
	border_size = 0,
	rounding = 0,
})

----------------------------------------------------------------------
-- Anonymous: per-app opacity
-- Polkit class is intentionally omitted — handled by the named rule above.
----------------------------------------------------------------------

local opacity_apps = {
	"wofi",
	"kitty",
	"firefox",
	"Spotify",
	"Code",
	"code-url-handler",
	"org.kde.dolphin",
	"org.kde.ark",
	"nwg-look",
	"qt5ct",
	"org.pwmt.zathura",
	"zen",
	"com.obsproject.Studio",
	"Signal",
	"pavucontrol",
	"blueman-manager",
	"nm-applet",
	"nm-connection-editor",
}
for _, cls in ipairs(opacity_apps) do
	hl.window_rule({ match = { class = cls }, opacity = OP .. " " .. OP })
end

----------------------------------------------------------------------
-- Anonymous: per-app float
----------------------------------------------------------------------

local float_apps = {
	"qt5ct",
	"nwg-look",
	"org.kde.ark",
	"Signal",
	"com.github.rafostar.Clapper",
	"app.drey.Warp",
	"net.davidotek.pupgui2",
	"yad",
	"eog",
	"io.gitlab.theevilskeleton.Upscaler",
	"pavucontrol",
	"blueman-manager",
	"nm-applet",
	"nm-connection-editor",
}
for _, cls in ipairs(float_apps) do
	hl.window_rule({ match = { class = cls }, float = true })
end
