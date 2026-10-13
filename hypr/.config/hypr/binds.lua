-- See https://wiki.hypr.land/Configuring/Basics/Binds/
--     https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local H = _G.HYPR
local mainMod = H.mainMod

----------------------------------------------------------------------
-- Window focus / movement / resize
----------------------------------------------------------------------

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -160, y =    0, relative = true }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x =  160, y =    0, relative = true }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x =    0, y = -160, relative = true }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x =    0, y =  160, relative = true }))

-- Move floating window with arrow keys
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + left",  hl.dsp.window.move({ x = -160, y =    0, relative = true }))
hl.bind(mainMod .. " + right", hl.dsp.window.move({ x =  160, y =    0, relative = true }))
hl.bind(mainMod .. " + up",    hl.dsp.window.move({ x =    0, y = -160, relative = true }))
hl.bind(mainMod .. " + down",  hl.dsp.window.move({ x =    0, y =  160, relative = true }))

----------------------------------------------------------------------
-- Window / session utilities
----------------------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload && killall waybar && nohup " .. H.scriptsDir .. "/statusbar &"))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + R",         hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + A",         hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + M",         hl.dsp.layout("splitratio 0.05"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("splitratio -0.05"))
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + Space",     hl.dsp.exec_cmd(H.scriptsDir .. "/changeLayout"))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exit())

----------------------------------------------------------------------
-- Special workspace
----------------------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + U",         hl.dsp.workspace.toggle_special(""))

----------------------------------------------------------------------
-- Workspace switch / move-to-workspace
----------------------------------------------------------------------

for i = 1, 10 do
  local key = i % 10  -- 10 -> 0
  hl.bind(mainMod .. " + "         .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + CTRL + "  .. key, hl.dsp.window.move({ workspace = i, follow = true }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + CTRL + bracketleft",  hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(mainMod .. " + CTRL + bracketright", hl.dsp.window.move({ workspace = "+1", follow = true }))
hl.bind(mainMod .. " + SHIFT + bracketleft",  hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1", follow = false }))

-- Scroll / cycle through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + period",     hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma",      hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + G",          hl.dsp.group.toggle())
hl.bind(mainMod .. " + tab",        hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("ALT + tab",         hl.dsp.focus({ workspace = "m+1" }))
hl.bind("ALT + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))

----------------------------------------------------------------------
-- Launchers
----------------------------------------------------------------------

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(H.scriptsDir .. "/launcher"))

-- Wallpaper, lockscreen, logout, color picker
hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd("python " .. H.wallpaper .. " --path " .. H.wallpapersDir))
hl.bind("CTRL + ALT + L",          hl.dsp.exec_cmd(H.lock))
hl.bind(mainMod .. " + X",         hl.dsp.exec_cmd(H.scriptsDir .. "/wlogout"))
hl.bind(mainMod .. " + CTRL + S",  hl.dsp.exec_cmd(H.colorpicker))

----------------------------------------------------------------------
-- Screenshots
----------------------------------------------------------------------

hl.bind("Print",                    hl.dsp.exec_cmd(H.screenshot .. " --now"))
hl.bind(mainMod .. " + Print",      hl.dsp.exec_cmd(H.screenshot .. " --in5"))
hl.bind("SHIFT + Print",            hl.dsp.exec_cmd(H.screenshot .. " --in10"))
hl.bind("CTRL + Print",             hl.dsp.exec_cmd(H.screenshot .. " --win"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(H.scriptsDir .. "/screen2gif"))
hl.bind(mainMod .. " + CTRL + t",   hl.dsp.exec_cmd(H.screenshot .. " --area"))

----------------------------------------------------------------------
-- Volume, brightness, media
----------------------------------------------------------------------

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(H.volume .. " --inc"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(H.volume .. " --dec"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(H.volume .. " --toggle"))
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop",         hl.dsp.exec_cmd("playerctl stop"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(H.backlight .. " --inc"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(H.backlight .. " --dec"))
hl.bind(mainMod .. " + SHIFT + B",         hl.dsp.exec_cmd("light -s sysfs/leds/tpacpi::kbd_backlight -S 100"))
hl.bind(mainMod .. " + CTRL + SHIFT + B",  hl.dsp.exec_cmd("light -s sysfs/leds/tpacpi::kbd_backlight -S 0"))

hl.bind(mainMod .. " + Y", hl.dsp.layout("togglesplit"))  -- dwindle only

----------------------------------------------------------------------
-- Apps
----------------------------------------------------------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(H.term))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(H.browser))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(H.files))
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd(H.audio))
hl.bind(mainMod .. " + S",      hl.dsp.exec_cmd(H.music))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd(H.editor))
hl.bind(mainMod .. " + T",      hl.dsp.exec_cmd("kitty --class tmux_picker --title tmux_picker -e " .. H.tmux_picker))
