-- Blur the background of these layer surfaces
hl.layer_rule({ match = { namespace = "wofi" },          blur = true })
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" },        blur = true })
