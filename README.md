# Config backup

This repository contains key configuration files for my development laptop.  
Setup guides and explanations for each tool will be updated.  
See individual directories for detailed information.

<!-- toc -->

- [Included Tools](#included-tools)
- [Installation](#installation)
  * [Nvim](#nvim)
  * [i3 & i3rs](#i3--i3rs)
  * [Alacritty Setup](#alacritty-setup)
- [How to Set Up xinput](#how-to-set-up-xinput)

<!-- tocstop -->

## Included Tools

- i3: Tiling window manager for X11
- i3status-rs: Customizable status bar written in Rust for i3
- picom: Compositor for X11 (for transparency and animations)
- [Nvim](./nvim): Terminal-based text editor
- tmux: Terminal multiplexer
- rofi: A dmenu replacement for launching apps, switching windows, and more

## Installation

Clone this repository first.

### Nvim

```bash
ln -s ~/config/nvim ~/.config/nvim
```

### i3 & i3rs

```bash
ln -s ~/config/i3rs-config.toml ~/.config/i3rs-config.toml
ln -s ~/config/i3/config ~/.config/i3/config
```

### Alacritty Setup

Create a symbolic link for the main Alacritty configuration file:

```bash
ln -s ~/config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```

The main configuration includes an import statement for a machine-specific.toml file to define device-specific settings. Create this file in the same directory and customize it, for example, by setting the font size:

```bash
echo -e "[font]\nsize = 12" > ~/.config/alacritty/machine-specific.toml
```

## How to configure input devices
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

Use `xinput list` and `xinput list-props <device-name>` to fTind the full device name and its available settings.

## How to configure displays

`autorandr` is used to automatically apply predefined display configurations.

1. Arrange your displays using `xrandr`
2. Save the current layout to a new profile (--force can be used to overwrite)

```bash
autorandr --forcce --save work
```
This setting is called from i3 config as follows.
```bash
exec --no-startup-id autorandr --change work 
```


## Refered links
- https://www.reddit.com/r/i3wm/comments/4tw1jn/tip_quasi_alternatingfibonacci_layout/
