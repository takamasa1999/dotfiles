-- disable netrw at the very start of init.lua. I use nvim-tree goodbye default file browser.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- In this stage, plugins are loaded.
require("config.lazy")

-- Read config options and keymaps
require("config.options")
require("config.keymaps")

-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#installation
require("lazy").setup({
	{ "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },
})
