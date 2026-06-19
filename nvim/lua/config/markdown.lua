local augroup = vim.api.nvim_create_augroup("custom_markdown", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "markdown",
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})
