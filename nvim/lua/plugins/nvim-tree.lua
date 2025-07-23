-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	keys = {
		{
			"<leader>e",
			"<cmd>NvimTreeToggle<CR>",
			desc = "Toggle File Explorer (nvim-tree)",
		},
	},
	config = function()
		require("nvim-tree").setup() -- use default settings
	end,
}
