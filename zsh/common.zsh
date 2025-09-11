export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gnzh"
plugins+=(vi-mode)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_NORMAL=2
VI_MODE_CURSOR_VISUAL=2
VI_MODE_CURSOR_INSERT=6
VI_MODE_CURSOR_OPPEND=0
# neovim
alias n='nvim'
export MANPAGER='nvim +Man!'
