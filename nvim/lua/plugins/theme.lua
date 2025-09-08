-- return {
-- 	"folke/tokyonight.nvim",
-- 	version = "4.11.0",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd.colorscheme("tokyonight-day")
-- 	end,
-- }

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		vim.cmd.colorscheme("catppuccin-latte")

		require("catppuccin").setup({
			float = {
				transparent = true, -- enable transparent floating windows
				solid = true, -- use solid styling for floating windows, see |winborder|
			},
		})
	end,
}
