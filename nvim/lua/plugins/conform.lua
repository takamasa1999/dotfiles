return {
	"stevearc/conform.nvim",
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
				javascript = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
			},
			format_on_save = nil,
		})
	end,
}
