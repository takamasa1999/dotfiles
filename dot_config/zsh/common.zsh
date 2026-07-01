export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
	source "$ZSH/oh-my-zsh.sh"
fi

alias n="nvim"
alias j="jobs -l"
alias history="fc -ln 1 | nvim -c $"
alias ccusage="bunx ccusage@latest"
alias ccusage-this-month="ccusage daily --since $(date +%Y%m01)"
alias s="kitten ssh"
alias gemini="agy"

f() {
	if (( $# == 0 )); then
		jobs -l
		return
	fi

	fg "%$1"
}

export MANPAGER="nvim +Man!"
export EDITOR="/opt/homebrew/bin/nvim"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export NLS_LANG="Japanese_Japan.AL32UTF8"

export OPENCODE_ENABLE_EXA=1

if command -v pyenv >/dev/null 2>&1; then
	eval "$(pyenv init - zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
	. "/opt/miniconda3/etc/profile.d/conda.sh"
elif [ -x "/opt/miniconda3/bin/conda" ]; then
	__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		export PATH="/opt/miniconda3/bin:$PATH"
	fi
	unset __conda_setup
fi

[ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ] && . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ] && . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

y() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

PROMPT=$'%{$fg_bold[green]%}%n@%m %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg_bold[blue]%} $%{$reset_color%} '
RPROMPT='%(1j.%{$fg_bold[yellow]%}[%j job%(2j.s.)]%{$reset_color%}.)'

[ -f "$HOME/.config/zsh/local.zsh" ] && source "$HOME/.config/zsh/local.zsh"
