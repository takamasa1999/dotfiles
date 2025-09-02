return {
	"folke/tokyonight.nvim",
	version = "4.11.0",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd.colorscheme("tokyonight-day")
	end,
}
