-- Smart gaps: only show gaps when there's more than one window on screen
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/#smart-gaps

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]",   gaps_out = 0, gaps_in = 0 })
