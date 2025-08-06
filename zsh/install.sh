#!/bin/bash

# Create alias of run command file
if [ -e ~/.zshrc ]; then
  echo "~/.zshrc already exists, aborting."
  exit 1
else
  ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
fi

# Clone oh-my-zsh and extensions
if [ -d ~/.oh-my-zsh ]; then
  echo "~/.oh-my-zsh already exists, skipping clone."
else
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  echo "zsh-autosuggestions already exists, skipping clone."
else
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# if [ -d ~/.oh-my-zsh/custom/plugins/zsh-vi-mode ]; then
#   echo "zsh-vi-mode already exists, skipping clone."
# else
#   git git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
# fi

