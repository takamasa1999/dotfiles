-- https://github.com/petertriho/nvim-scrollbar
return {
	"petertriho/nvim-scrollbar",
	dependencies = {
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		local colors = require("cyberdream.colors").light
		require("scrollbar").setup({
			marks = {
				Search = { color = colors.blue },
				-- Error = { color = colors.error },
				-- Warn = { color = colors.warning },
				-- Info = { color = colors.info },
				-- Hint = { color = colors.hint },
				-- Misc = { color = colors.purple },
			},
		})
		require("scrollbar.handlers.search").setup()
	end,
}
