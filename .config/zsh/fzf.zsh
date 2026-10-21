# fzf: ctrl+f history, ctrl+t files, alt+c cd, **<tab> completion
(( $+commands[fzf] )) || return

export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --info=inline'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_R_OPTS="--preview 'echo {2..}' --preview-window=down:3:wrap:hidden --bind '?:toggle-preview'"

source <(fzf --zsh)

# Keep plain ^R as default incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^F' fzf-history-widget
