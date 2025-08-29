return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
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
				update_root = true, -- update root to the file's project root
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
			},
		})
	end,
}
