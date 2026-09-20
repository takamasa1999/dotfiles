return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {},
	config = function()
		local hooks = require("ibl.hooks")

		-- 1px colored lines do not render hue on Color E-ink, so use one gray.
		-- Set in the hook so it survives every colorscheme change.
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblGray", { fg = "#b0b0b0" })
		end)

		require("ibl").setup({ indent = { highlight = { "IblGray" } } })
	end,
}
