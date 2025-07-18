#Config backup
This repository contains key configuration files for my development laptop.    
Setup guides and explanations for each tool will be updated.  
See individual directories for detailed information.

## Included Tools
- i3: Tiling window manager for X11
- i3status-rs: Customizable status bar written in Rust for i3
- picom: Compositor for X11 (for transparency and animations)
- [Nvim](./nvim): Terminal-based text editor  
- tmux: Terminal multiplexer
- rofi: A dmenu replacement for launching apps, switching windows, and more

## How to Set Up xinput

To persist your settings even after plugging or unplugging devices, store the configuration files in:

`/etc/X11/xorg.conf.d/`

Here’s an example configuration:

Section "InputClass"  
    Identifier "BluetoothMouse3600"  
    MatchProduct "BluetoothMouse3600 Mouse"  
    MatchIsPointer "on"  
    Driver "libinput"  
    Option "AccelSpeed" "-0.5"  
    Option "MiddleEmulation" "on"  
EndSection

Use `xinput list` and `xinput list-props <device-name>` to find the full device name and its available settings.
