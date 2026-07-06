hl.monitor({ output = "DP-1", mode = "preferred", position = "auto", scale = 1.5 })
hl.monitor({ output = "HDMI-A-2", mode = "preferred", position = "auto", scale = 0.833 })
-- hl.monitor({ output = "DP-1", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Per-workspace monitor pinning (kept commented to mirror the old monitors.conf intent)
-- for i = 1, 5  do hl.workspace_rule({ workspace = i, monitor = "DP-3" }) end
-- for i = 6, 10 do hl.workspace_rule({ workspace = i, monitor = "DP-1" }) end
