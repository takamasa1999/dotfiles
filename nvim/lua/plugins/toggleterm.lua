return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{
				"<leader>t",
				function()
					require("toggleterm").toggle()
				end,
				desc = "Toggle Terminal",
			},
		},
		config = function()
			require("toggleterm").setup({
				direction = "horizontal",
				size = 10, -- adjust size as you like
				open_mapping = nil, -- we handle keymaps manually
			})
		end,
	},
}
