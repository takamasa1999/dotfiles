-- https://github.com/akinsho/toggleterm.nvim
return {
	"akinsho/toggleterm.nvim",
	version = "2.13.1",
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
			return 20
		end,
		open_mapping = nil, -- We'll set this in keymaps.lua
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},
	config = function()
		require("toggleterm").setup()
		local keymap = vim.keymap.set
		keymap({ "n", "t" }, "<A-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
	end,
}
