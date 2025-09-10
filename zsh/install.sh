#!/bin/bash

# Create alias of run command file
if [ -e ~/.zshrc ]; then
	echo "~/.zshrc already exists, aborting."
	exit 1
else
	ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
fi

oh_my_zsh_dir=~/.oh-my-zsh
# Clone oh-my-zsh and extensions
if [ -d $oh_my_zsh_dir ]; then
	echo "~/.oh-my-zsh already exists, skipping clone."
else
	git clone https://github.com/ohmyzsh/ohmyzsh.git $oh_my_zsh_dir
fi

zsh_autosuggestions_dir=~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
if [ -d $zsh_autosuggestions_dir ]; then
	echo "zsh-autosuggestions already exists, skipping clone."
else
	git clone https://github.com/zsh-users/zsh-autosuggestions $zsh_autosuggestions_dir
fi

zsh_syntax_highlighting_dir=~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
if [ -d $zsh_syntax_highlighting_dir ]; then
	echo "zsh-syntax-highlighting already exists, skipping clone."
else
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $zsh_syntax_highlighting_dir
fi
