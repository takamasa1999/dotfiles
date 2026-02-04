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
				markdown = {
					"prettier",
					-- "doctoc",
					"markdown-toc",
				},
				bash = { "shfmt" },
				zsh = { "shfmt" },
				javascript = { "prettier" },
				python = { "black" },
				json = { "prettier" },
				yaml = { "prettier" },
				tex = {
					"tex-fmt",
				},
				c = { "clang_format" },
			},
			formatters = {
				["tex-fmt"] = {
					-- command = "tex-fmt",
					append_args = { "--nowrap" },
				},
			},
			format_on_save = nil,
		})
	end,
}
