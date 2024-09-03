# source zsh aliases
source $HOME/.config/zsh/zsh_aliases

# History in cache directory:
HISTFILE=$HOME/.config/zsh/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Turn off all beeps
unsetopt BEEP

# Export envvars
export EDITOR='/usr/bin/nvim' # Editor
export VISUAL='/usr/bin/nvim' # Visual editor
export PATH="$HOME/.local/bin:$PATH" # For user binaries
export PAGER="most" # color manpages
export SSH_AUTH_SOCK=~/.1password/agent.sock # For 1password to manage ssh keys
export PATH="$HOME/.pyenv/bin:$PATH" # For pyenv
export VIRTUAL_ENV_DISABLE_PROMPT=tr # For starship prompt 
export TERM="xterm-kitty" # For kitty terminal
export RANGER_LOAD_DEFAULT_RC=false # For ranger

# Keybindings
bindkey -v # enable vim mode
bindkey ^R history-incremental-search-backward 
bindkey ^S history-incremental-search-forward
bindkey '^ ' autosuggest-accept # bind strg+space to accept

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init --cmd cd zsh)"

fpath+=~/.zfunc
autoload -Uz compinit && compinit
if [ -f "/home/weygoldt/.config/fabric/fabric-bootstrap.inc" ]; then . "/home/weygoldt/.config/fabric/fabric-bootstrap.inc"; fi
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/weygoldt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/weygoldt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/weygoldt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/weygoldt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

