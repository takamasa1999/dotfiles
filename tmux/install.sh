#!/bin/bash


# Clone oh my tmux
if [ -d ~/.tmux]; then
  echo "~/.tmux already exists, skipping clone."
else
  git clone --single-branch https://github.com/gpakosz/.tmux.git ~/.tmux
fi

# Create alias of config file
if [ -e ~/.tmux.conf]; then
  echo "~/.tmux.conf already exists, aborting."
  exit 1
else
  ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
fi

if [ -e ~/.tmux.conf.local]; then
  echo "~/.tmux.conf.local already exists, aborting."
  exit 1
else
  ln -s ~/config/tmux/tmux.conf.local ~/.tmux.conf.local
fi
