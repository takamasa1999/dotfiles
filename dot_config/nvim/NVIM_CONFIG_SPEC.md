# Neovim Configuration Specification

## Overview

This repository is a Lua-based Neovim configuration. `init.lua` disables netrw, bootstraps the plugin system, then loads core settings from `lua/config/`. Plugin definitions are grouped under `lua/plugins/` and imported through `lazy.nvim`.

## Boot Flow

1. `init.lua` disables `netrw` and `netrwPlugin`.
2. `lua/config/lazy.lua` bootstraps `folke/lazy.nvim` from the stable branch if it is missing.
3. `lazy.nvim` imports grouped specs from `lua/plugins/init.lua`.
4. Core modules are loaded afterward:
   - `lua/config/options.lua`
   - `lua/config/keymaps.lua`
   - `lua/config/format.lua`
   - `lua/config/markdown.lua`

The leader key is Space. The local leader is backslash.

## Core Editor Settings

`lua/config/options.lua` sets common editor behavior:

- 4-space indentation via `shiftwidth` and `tabstop`.
- Relative and absolute line numbers.
- Rounded window borders.
- Very large `scrolloff` to keep the cursor vertically centered.
- OSC52 clipboard integration with `unnamedplus`.
- Automatic file reload checks on focus, buffer enter, cursor hold, and terminal leave.
- Relative numbers inside terminal, help, and man buffers.

## Plugin Management

Plugins are managed by `folke/lazy.nvim`. The lockfile is `lazy-lock.json`. Specs are grouped by purpose under `lua/plugins/coding/`, `lua/plugins/editor/`, `lua/plugins/git/`, `lua/plugins/ui/`, and `lua/plugins/languages/`. Plugin update checking is disabled with `checker = { enabled = false }`. The install colorscheme fallback is `cyberdream-light`.

External language tools are managed by:

- `mason-org/mason.nvim`: UI and install root for language servers/tools.
- `WhoIsSethDaniel/mason-tool-installer.nvim`: automatically installs configured tools, runs on startup, auto-updates, and debounces checks for 5 hours.

Configured Mason tools include Lua, Bash, Markdown, Python, typo, and prose language servers plus `stylua`, `prettier`, `shfmt`, `black`, `markdown-toc`, and `eslint_d`.

## LSP Setup

`lua/plugins/coding/lsp.lua` configures Neovim's built-in LSP client through `neovim/nvim-lspconfig`.

Enabled servers:

- `typos_lsp`: typo diagnostics.
- `ltex_plus`: prose, grammar, and writing checks.
- `bashls`: shell scripts, including `sh`, `bash`, and `zsh`.
- `sourcekit`: Swift and Apple platform language support.
- `lua_ls`: Lua and Neovim config development.
- `systemd_ls`: systemd unit files.
- `marksman`: Markdown language support.
- `basedpyright` and `pyright`: Python type checking and navigation.
- `dockerls`: Dockerfile support.
- `yamlls`: YAML support.
- `texlab`: LaTeX support.
- `eslint_lsp`: JavaScript/TypeScript lint-aware LSP support.
- `biome`: web formatting/linting ecosystem support.
- `rust_analyzer`: Rust language support.

Each server is registered with `vim.lsp.config(name, config)` and enabled with `vim.lsp.enable(name)`, which uses the modern Neovim LSP API.

LSP keymaps:

- `<leader>ca`: code action.
- `<leader>rn`: rename symbol.
- `K`: hover documentation.
- `<C-s>` in insert mode: signature help.
- `gd`, `gr`, `gi`, `gD`: definition, references, implementation, type definition.
- `gO`: document symbols.
- `<leader>ws`: workspace symbols.

`folke/lazydev.nvim` improves Lua development by loading Neovim/Luv library metadata for Lua files.

## Formatting

Formatting is handled by `stevearc/conform.nvim` in `lua/plugins/coding/formatting.lua`.

Formatters by filetype:

- Lua: `stylua`
- CSS, HTML, JavaScript, JSON, YAML: `prettier`
- Markdown: custom `prettier_markdown`, then `markdown-toc`
- Bash and Zsh: `shfmt`
- Python: `black`
- TeX: `tex-fmt` with `--nowrap`
- C: `clang_format`

Automatic format-on-save is disabled (`format_on_save = nil`). Manual formatting is defined in `lua/config/format.lua`:

- `<leader>fm`: runs `conform.format({ async = true, lsp_format = "fallback" })`.

This means Conform uses configured external formatters first and falls back to LSP formatting when needed.

## Linting

Linting is handled by `mfussenegger/nvim-lint` in `lua/plugins/coding/linting.lua`.

Current mapping:

- Bash: `shellcheck`

The plugin defines linters by filetype only. No autocmd is currently configured here to automatically trigger linting, so lint execution depends on manual use or future autocmd additions.

## Completion and Snippets

Completion is provided by `saghen/blink.cmp`.

Sources:

- LSP
- Path
- Snippets
- Buffer

`rafamadriz/friendly-snippets` supplies snippet collections. Copilot integration for Blink is present in comments but disabled.

Behavior:

- Completion uses the `enter` preset.
- `<C-s>` shows completion documentation.
- Documentation auto-shows immediately.
- Completion does not auto-show immediately on insert.
- Items are not preselected and are not auto-inserted.
- The menu displays kind icon, label, label description, and source name.
- Command-line completion is enabled and auto-shows.
- Fuzzy matching prefers the Rust implementation, with a warning fallback.

## AI Assistance

`zbirenbaum/copilot.lua` is loaded on insert. Inline suggestions are enabled and auto-triggered.

Copilot keymaps:

- `<Right>`: accept suggestion.
- `<C-Right>`: accept word.
- `<Down>`: accept line.
- `<M-n>` / `<M-p>`: next and previous suggestions.
- `<M-x>`: dismiss.

Copilot is explicitly enabled for Markdown and TeX files.

## Navigation, Search, and Project Movement

Navigation/search plugins:

- `nvim-telescope/telescope.nvim`: fuzzy finding, grep, help, commands, buffers, and old files.
- `incptr/telescope-live-grep-oldfiles.nvim`: extension for grepping old files.
- `stevearc/aerial.nvim`: code outline and symbol navigation.
- `MagicDuck/grug-far.nvim`: find and replace UI.
- `stevearc/oil.nvim`: file explorer that edits directories as buffers.

Important keymaps:

- `<leader>ff`: find files.
- `<leader>fg`: live grep.
- `<leader>fh`: help tags.
- `<leader>fc`: commands.
- `<A-b>` or `<leader>b`: buffers.
- `<leader>fof`: old files.
- `<leader>fr`: find and replace.
- `<leader>oo`: toggle Aerial outline.
- `{` / `}` inside Aerial buffers: previous/next symbol.
- `-`: open parent directory with Oil.

## Git Integration

Git features are split across:

- `lewis6991/gitsigns.nvim`: inline signs, hunk navigation, preview, blame, and diff.
- `NeogitOrg/neogit`: full Git status and workflow UI.
- `sindrets/diffview.nvim`: Neogit diff integration.

Keymaps:

- `<leader>gd`: diff current file with Gitsigns.
- `[c` / `]c`: previous/next Git hunk.
- `gb`: blame current line.
- `<leader>gb`: blame file.
- `gh`: preview hunk.
- `<leader>gp`: open Neogit.

## UI and Visual Enhancements

Visual/UI plugins:

- `scottmckendry/cyberdream.nvim`: active colorscheme, using `cyberdream-light`.
- `nvim-lualine/lualine.nvim`: statusline with mode, branch, diff, diagnostics, filename, encoding, filetype, progress, and location.
- `akinsho/bufferline.nvim`: configured in tab mode with slanted separators and hidden close icons.
- `lukas-reineke/indent-blankline.nvim`: rainbow indent guides using Cyberdream colors.
- `petertriho/nvim-scrollbar`: scrollbar with search mark integration through `nvim-hlslens`.
- `kevinhwang91/nvim-ufo`: folding UI backed by LSP fold ranges.
- `folke/which-key.nvim`: keymap discovery with zero delay.
- `nvim-tree/nvim-web-devicons` and `mini.icons`: icon dependencies.

Folding:

- `zR`: open all folds.
- `zM`: close all folds.

## Editing Helpers

Editing-focused plugins:

- `windwp/nvim-autopairs`: automatic paired brackets and quotes in insert mode.
- `numToStr/Comment.nvim`: linewise comments.
- `kylechui/nvim-surround`: add/change/delete surrounding characters.
- `monaqa/dial.nvim`: increment/decrement numbers, dates, semver, booleans, on/off, and log levels.
- `mbbill/undotree`: undo history browser.
- `lambdalisue/vim-suda`: save files with elevated permissions.
- `kevinhwang91/nvim-bqf`: quickfix window preview.
- `arnamak/stay-centered.nvim`: keeps cursor centered while moving.

Keymaps:

- `<leader>/`: toggle comment in normal or visual mode.
- `<A-=>` / `<A-->`: increment/decrement with Dial.
- `<A-u>`: toggle Undotree.
- `<leader>S`: sudo write.
- `<leader>s` or `<C-s>`: write buffer.
- `<leader>q` / `<leader>Q`: quit / force quit.
- `<A-t>`: open a terminal in a new tab.

## Markdown and Writing

Markdown-specific setup is split between `lua/config/markdown.lua` and plugin specs.

Markdown behavior:

- `conceallevel = 2`
- tabs are preserved with `expandtab = false`
- tab width, shift width, and soft tab stop are set to 4

Markdown plugins:

- `iamcco/markdown-preview.nvim`: browser preview, built with `yarn install`.
- `MeanderingProgrammer/render-markdown.nvim`: in-editor Markdown rendering, with LSP completions enabled.
- `marksman`: Markdown LSP.
- `ltex_plus`: prose checking.
- `typos_lsp`: typo checking.

Preview keymap:

- `<leader>p`: open Markdown preview.

Preview settings keep auto-start off, auto-close off, light theme on, YAML metadata hidden, and sync scroll enabled.

## LaTeX

LaTeX support is provided by:

- `lervag/vimtex`: LaTeX editing workflow.
- `texlab`: LSP support.
- `tex-fmt`: formatting through Conform.

VimTeX settings:

- Viewer: `skim`
- Syntax conceal disabled.
- VimTeX syntax disabled.

## Treesitter

`nvim-treesitter/nvim-treesitter` is loaded eagerly and runs `:TSUpdate` on build.

Configured parsers:

- C
- Lua
- Rust
- Markdown
- Markdown inline
- Mermaid

Missing parsers are auto-installed. JavaScript is ignored. The config also restores a custom Markdown injection query if a non-plugin runtime query is found.

## File Explorer and Assets

`oil.nvim` is the active file explorer. `nvim-tree` is present only as commented-out code in `lua/plugins/editor/files.lua`.

Image and diagram support are present but disabled:

- `3rd/image.nvim`
- `3rd/diagram.nvim`

Both are configured for Markdown-like workflows but have `enabled = false`.

## Custom Utilities

There are custom smart-close utilities under `lua/custom-utilities/`, but they are not currently required from `init.lua`.

Notable files:

- `lua/custom-utilities/smart-close/init.lua`
- `lua/custom-utilities/smart-close/utils.lua`
- `lua/custom-utilities/smartClose.lua`

They implement buffer counting through `:ls` output and close behavior that prefers buffer deletion before quitting Neovim.

## Disabled and Experimental Plugins

Disabled plugin specs live in `lua/plugins/disabled/`. This directory includes old or paused configurations for dashboard/start screen, terminal, image, Obsidian, remote editing, status column, completion, Treesitter, Xcode, and other experiments. These files are useful references but are not imported by `lazy.nvim` unless moved back into `lua/plugins/` or explicitly imported.

## Maintenance Notes

Recommended checks:

- `stylua .`: format Lua files.
- `luacheck .`: lint Lua.
- `luac -p init.lua`: syntax-check the entry point.
- `nvim --headless "+Lazy! sync" +qa`: sync plugins headlessly.

For shell-related changes, use `shfmt`, `shellcheck`, and `bash -n` or `zsh -n` as appropriate.
