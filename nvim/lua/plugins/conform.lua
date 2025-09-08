return {
	"stevearc/conform.nvim",
	version = "9.1.0",
	config = function()
		-- https://github.com/stevearc/conform.nvim
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				css = { "prettier" },
				html = { "prettier" },
				markdown = { "prettier", "markdown-toc" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				javascript = { "prettier" },
				python = { "black" },
				json = { "prettier" },
			},
			format_on_save = nil,
		})
	end,
}
