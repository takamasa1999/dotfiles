-- ~/.config/nvim/lua/plugins/tokyonight.lua
return {
	"folke/tokyonight.nvim",
	lazy = false, -- load immediately
	priority = 1000, -- make sure it loads before other colorschemes
	-- opts = {
	-- 	style = "night", -- "storm", "night", "moon", "day"
	-- 	light_style = "day",
	-- 	transparent = false,
	-- 	terminal_colors = true,
	-- 	styles = {
	-- 		comments = { italic = true },
	-- 		keywords = { italic = true },
	-- 		functions = {},
	-- 		variables = {},
	-- 		sidebars = "day",
	-- 		floats = "day",
	-- 	},
	-- 	day_brightness = 1,
	-- 	dim_inactive = false,
	-- 	lualine_bold = false,
	-- },
}
