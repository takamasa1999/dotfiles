# My Neovim configuration

Here, I'll build up my personalized best Neovim configuration from scratch.  

## Why build up from scratch?
I use Neovim only for quick local file modifications, but on various operating systems.  
If it needs to go further as a container or remote development, I usually switch to VS Code. Because it comes with rich extensions so I don't need to scratch my head to rice it up.  
Therefore, I want the setting for Neovim to be **as minimal as possible** to make it work quickly and reliably in **any environment**.  
Additionally, I want to customize settings such as relative line number display, custom keybindings, and other detailed configurations, since these are the benefits of using Neovim. Personalization.  
So, I decided to build the configuration from scratch.

## Installation
- Run the command below in the Neovim command mode to check the config dir
```vim
:echo stdpath('config')
```

- Clone this repository into the directory