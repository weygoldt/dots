#!/usr/bin/env bash

session=$(tmux list-sessions -F "#{session_name}" |
          fzf --prompt="Tmux ❯ " \
              --preview-window=top:80% \
              --preview 'tmux capture-pane -epJ -t {}:')
[ -n "$session" ] && exec tmux attach -t "$session"
