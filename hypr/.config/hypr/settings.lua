-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
	general = {
		gaps_in = 3, -- 6px between windows
		gaps_out = 6, -- single windows stay edge to edge (workspacerules.lua)
		border_size = 2,
		col = {
			-- active_border   = { colors = { "rgba(24bbffaa)", "rgba(ff3dcfaa)" }, angle = 45 },
			active_border = "rgba(6C7A89aa)",
			inactive_border = "rgba(000000FF)",
		},
		layout = "dwindle",
	},

	decoration = {
		rounding = 6, -- matches the waybar pills and wlogout cards
		blur = {
			enabled = true,
			xray = true,
			special = true,
			new_optimizations = true,
			size = 5,
			passes = 4,
			brightness = 1,
			noise = 0,
			contrast = 0.5,
			popups = true,
			popups_ignorealpha = 0.6,
		},
		dim_inactive = false,
		dim_strength = 0.1,
		dim_special = 0,
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
		special_scale_factor = 0.5,
	},

	master = {
		special_scale_factor = 0.8,
		mfact = 0.5,
	},

	gestures = {
		-- workspace_swipe         = true,
		-- workspace_swipe_fingers = 3,
	},

	input = {
		kb_layout = "us",
		-- kb_variant      = "",
		-- kb_model        = "",
		kb_options = "caps:swapescape",
		-- kb_rules        = "",
		follow_mouse = 2,
		numlock_by_default = true,
		sensitivity = 0.2,
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = true,
			disable_while_typing = true,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		mouse_move_enables_dpms = true,
		enable_anr_dialog = false,
		-- no_direct_scanout     = true,
	},

	binds = {
		workspace_back_and_forth = true,
	},
})

----------------------------------------------------------------------
-- Animation curves
----------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("softAcDecel", { type = "bezier", points = { { 0.26, 0.26 }, { 0.15, 1 } } })
hl.curve("md2", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } }) -- use with .2s

----------------------------------------------------------------------
-- Animations
----------------------------------------------------------------------

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })
-- hl.animation({ leaf = "layers",        enabled = true, speed = 2,    bezier = "md3_decel",  style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
-- hl.animation({ leaf = "workspaces",    enabled = true, speed = 2.5,  bezier = "softAcDecel",style = "slide" })
-- hl.animation({ leaf = "workspaces",    enabled = true, speed = 7,    bezier = "menu_decel", style = "slidefade 15%" })
-- hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel",  style = "slidefadevert 15%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidevert" })
