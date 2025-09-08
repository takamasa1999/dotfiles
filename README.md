# Dotfiles

Personalized configurations and scripts for my beloved ROG Flow X13.  
Powered by i3 and Fedora 42 — the ultimate combo.
This setup is tailored specifically for my environment, as there's little documentation out there for it.  
If you're referencing this repository, make sure to double-check whether the commands and configs fit your own system.

<!-- toc -->

- [Installation](#installation)
    * [Terminal essentials](#terminal-essentials)
        + [Zsh](#zsh)
        + [Nvim](#nvim)
        + [Opencode](#opencode)
    * [Tmux](#tmux)
    * [picom](#picom)
    * [rofi](#rofi)
    * [i3 & i3rs & i3wsr](#i3--i3rs--i3wsr)
    * [Alacritty](#alacritty)
    * [Custom scripts](#custom-scripts)
- [Uninstallation](#uninstallation)
- [Tips](#tips)
    * [How to configure input devices](#how-to-configure-input-devices)
    * [How to configure displays](#how-to-configure-displays)
    * [Key Events](#key-events)
    * [How to Fibonacci Layout on i3?](#how-to-fibonacci-layout-on-i3)
    * [Nvim tutorials](#nvim-tutorials)
    * [How to keep remote sessions alive on Tmux](#how-to-keep-remote-sessions-alive-on-tmux)

<!-- tocstop -->

## Installation

Each part of the setup is introduced separately, allowing you to install only what you need — ideal for selective setups on other environments like servers.

### Terminal essentials

#### Zsh

```bash
~/dotfiles/zsh/install.sh
```

#### Nvim

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

#### Opencode

[Config](https://opencode.ai/docs/config)

```bash
ln -s ~/dotfiles/opencode/opencode.json ~/.config/opencode/opencode.json
```

### Tmux

```bash
~/dotfiles/tmux/install.sh
```

### picom

```bash
ln -s ~/dotfiles/picom.conf ~/.config/picom.conf
```

### rofi

```bash
ln -s ~/dotfiles/rofi ~/.config/rofi
```

### i3 & i3rs & i3wsr

```bash
ln -s ~/dotfiles/i3 ~/.config/i3
ln -s ~/dotfiles/i3rs-config.toml ~/.config/i3rs-config.toml
ln -s ~/dotfiles/i3wsr ~/.config/i3wsr
```

### Alacritty

Create a symbolic link for the main Alacritty configuration file and theme:

```bash
ln -s ~/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -s ~/dotfiles/alacritty/theme.toml ~/.config/alacritty/theme.toml
```

The main configuration includes an import statement for a machine-specific.toml file to define device-specific settings. Create this file in the same directory and customize it, for example, by setting the font size:

```bash
echo -e "[font]\nsize = 12" > ~/.config/alacritty/machine-specific.toml
```

### Custom scripts

Add bin directory to your $PATH

## Uninstallation

This section is a work in progress.  
Be extra careful — these commands will remove config files and symlinks.  
**Read everything before you run anything.**

```bash
cd ~/.config
rm -r i3 i3rs-config.toml i3wsr nvim rofi ./alacritty/alacritty.toml

cd ~
rm .zshrc .tmux.conf.local
```

## Tips

### How to configure input devices

`xinput` is used to change the configurations.
To persist your settings even after plugging or unplugging devices, store the conf files in:

`/etc/X11/xorg.conf.d/`

Here’s an example configuration:

```bash
Section "InputClass"
 Identifier "BluetoothMouse3600"
 MatchProduct "BluetoothMouse3600 Mouse"
 MatchIsPointer "on"
 Driver "libinput"
 Option "AccelSpeed" "-0.5"
 Option "MiddleEmulation" "on"
EndSection
```

Use `xinput list` and `xinput list-props <device-name>` to find the full device name and its available settings.

### How to configure displays

`autorandr` is used to automatically apply predefined display configurations.

1. Arrange your displays using `xrandr`
2. Save the current layout to a new profile (--force can be used to overwrite)

```bash
autorandr --forcce --save work
```

The appropriate setting in a setting will be automatically called.
You can check the state by calling autorandr.

### Key Events

Assigned Caps Lock key to display notification when it's active.
https://wiki.archlinux.org/title/Xbindkeys

Used [keyd(https://github.com/rvaiya/keyd) to remap capslock to escape when pressed alone, and to control when held down.

### How to Fibonacci Layout on i3?

https://www.reddit.com/r/i3wm/comments/4tw1jn/tip_quasi_alternatingfibonacci_layout/

### Nvim tutorials

- [Project wide renaming](https://www.youtube.com/watch?v=9JCsPsdeflY&t=215s)

### How to keep remote sessions alive on Tmux

For better connectivity and resilience against unstable networks, I use Mosh instead of plain SSH.

- [Fix locale issue](https://ichimusai.org/fix-mosh-locale/)
  ```bash
  locale-gen "en_US.UTF-8"
  update-locale LC_ALL="en_US.UTF-8"
  ```
