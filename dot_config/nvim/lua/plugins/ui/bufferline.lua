-- https://github.com/akinsho/bufferline.nvim?tab=readme-ov-file#tabs
return {
	"akinsho/bufferline.nvim",
	version = "4.9.1",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		-- Check help with :h bufferline-configuration

		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "tabs",
				separator_style = "slant",
				-- offsets = {
				-- 	{
				-- 		filetype = "NvimTree",
				-- 		text = "File Explorer",
				-- 		text_align = "center",
				-- 		separator = true,
				-- 	},
				-- },
				show_buffer_close_icons = false,
				show_close_icon = false,
				-- always_show_bufferline = true,
				-- show_tab_indicators = true,
				--
				-- enforce_regular_tabs = true,
				-- persist_buffer_sort = false,
			},
		})
	end,
}
