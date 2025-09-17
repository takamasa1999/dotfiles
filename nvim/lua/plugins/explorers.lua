local tree = {
	"nvim-tree/nvim-tree.lua",
	version = "1.14.0",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			sync_root_with_cwd = true, -- sync tree root with Neovim's cwd
			respect_buf_cwd = true, -- respect buffer cwd
			update_focused_file = {
				enable = true,
				-- update_root = true, -- update root to the file's project root
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			renderer = {
				root_folder_modifier = false,
			},
			view = {
				relativenumber = true,
				width = 50,
			},
		})

		local keymap = vim.keymap.set
		keymap({ "n", "i", "v" }, "<A-e>", "<esc><Cmd>NvimTreeToggle<CR>", { desc = "Toggle explorer" })
	end,
}

local oil = {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		require("oil").setup()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}

return { tree, oil }
