# source zsh aliases
source $HOME/.config/zsh/zsh_aliases

# History (kept in XDG state dir, out of the dotfiles tree)
HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY       # Save timestamps and durations
setopt SHARE_HISTORY          # Share history between running shells
setopt HIST_IGNORE_ALL_DUPS   # Drop older duplicates of a command
setopt HIST_IGNORE_SPACE      # Don't save commands starting with a space
setopt HIST_REDUCE_BLANKS

# SFW mode (hypr/scripts/sfw): new shells start with an empty, unsaved
# history, no autosuggestions and an empty zoxide; the real files stay untouched.
if [[ -f $HOME/.local/state/sfw-mode ]]; then
	SFW_MODE=1
	unset HISTFILE
	export _ZO_DATA_DIR=${XDG_RUNTIME_DIR:-/tmp}/sfw-zoxide
	mkdir -p "$_ZO_DATA_DIR"
	export YAZI_CONFIG_HOME=$HOME/.config/hypr/sfw/yazi # yazi without media previews
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
[[ -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh ]] || mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/zsh
compinit -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump
_comp_options+=(globdots) # Include hidden files.

# Plugins
[[ -z $SFW_MODE ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Turn off all beeps
unsetopt BEEP

# Export envvars
typeset -U path # Keep PATH free of duplicates in nested shells
path=($HOME/.local/bin $HOME/.npm-global/bin $path) # User binaries
export EDITOR='/usr/bin/nvim' # Editor
export VISUAL='/usr/bin/nvim' # Visual editor
export PAGER="most" # color manpages
export VIRTUAL_ENV_DISABLE_PROMPT=1 # For starship prompt
export RANGER_LOAD_DEFAULT_RC=false # For ranger

# Keybindings
bindkey -v # enable vim mode
bindkey ^R history-incremental-search-backward
bindkey ^S history-incremental-search-forward
bindkey '^ ' autosuggest-accept # bind strg+space to accept

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(direnv hook zsh)"
