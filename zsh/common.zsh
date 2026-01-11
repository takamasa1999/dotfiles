# Migration from bash
export PATH="$HOME/.local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

EDITOR="nvim"

plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
plugins+=(zsh-vi-mode)

# This must be called after local settings
source $ZSH/oh-my-zsh.sh

# neovim is life
alias n="nvim"
export MANPAGER="nvim +Man!"

# for mosh connection
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Custom theme
PROMPT=$'%{$fg_bold[green]%}%n@%m %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg_bold[blue]%} $%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# other aliases
alias history='fc -ln 1 | nvim -c $'
