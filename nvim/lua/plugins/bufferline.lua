return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		-- https://github.com/akinsho/bufferline.nvim?tab=readme-ov-file#tabs
		-- Check help with :h bufferline-configuration

		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				separator_style = "slant",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
				show_tab_indicators = true,

				sort_by = "insert_after_current",
			},
		})
	end
}
