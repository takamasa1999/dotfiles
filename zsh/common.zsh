# Migration from bash
export PATH="$HOME/.local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

# zsh plugins
plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
# plugins+=(zsh-vi-mode)

# This must be called after local settings
source $ZSH/oh-my-zsh.sh

# neovim as default editor
alias n="nvim"
export MANPAGER="nvim +Man!"
EDITOR="nvim"

# for mosh connection
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# enable websearch on opencode
export OPENCODE_ENABLE_EXA=1

# Custom theme
PROMPT=$'%{$fg_bold[green]%}%n@%m %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg_bold[blue]%} $%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# other aliases
alias history='fc -ln 1 | nvim -c $'
alias ccusage='bunx ccusage'
alias ccusage-this-month='ccusage daily --since $(date +%Y%m01)'
alias s="kitten ssh"

# Run tmux at start up
# [ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }
