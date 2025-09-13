export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh"
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
