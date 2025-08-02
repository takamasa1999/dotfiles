local options = {
	-- Experimental implementation. Doesn't work.
	-- formatters = {
	--   markdown_toc = {
	--     command = "markdown-toc",
	--     args = { "-i", "$FILENAME" },
	--   },
	-- },
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettier" },
		html = { "prettier", "htmlhint" },
		markdown = { "prettier", "markdown_toc" },
	},
	format_on_save = false,
}

return options
