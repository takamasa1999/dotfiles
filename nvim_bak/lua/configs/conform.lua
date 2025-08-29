local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettier", "markdown-toc" },
		bash = { "shfmt" },
		zsh = { "shfmt" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = false,
}

return options
