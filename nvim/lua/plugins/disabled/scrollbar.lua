return {
	-- https://github.com/petertriho/nvim-scrollbar
	"petertriho/nvim-scrollbar",
	dependencies = {
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		local colors = require("cyberdream.colors").light
		require("scrollbar").setup({
			-- handle = {
			-- 	color = colors.bg_highlight,
			-- },
			marks = {
				-- Search = { color = colors.orange },
				-- Error = { color = colors.error },
				-- Warn = { color = colors.warning },
				-- Info = { color = colors.info },
				-- Hint = { color = colors.hint },
				-- Misc = { color = colors.purple },
			},
		})
	end,
}
