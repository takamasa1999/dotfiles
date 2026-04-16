return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "takamasa-personal",
				path = "/Users/takamasa/Documents/obsidian",
			},
		},
	},
	keys = {
		{ "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Obsidian Note" },
		{ "<leader>os", "<cmd>Obsidian quick_switch<cr>", desc = "Obisidian search by note name" },
		{ "<leader>oS", "<cmd>Obsidian search<cr>", desc = "Obsidian search by words" },
	},
}
