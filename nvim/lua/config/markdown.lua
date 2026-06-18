local augroup = vim.api.nvim_create_augroup("custom_markdown", { clear = true })

local function fold_mermaid_blocks()
	if vim.bo.filetype ~= "markdown" then
		return
	end

	local cursor = vim.api.nvim_win_get_cursor(0)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local in_mermaid = false
	local start_line = nil

	vim.opt_local.foldmethod = "manual"
	vim.opt_local.foldopen:remove("insert")
	vim.cmd("silent! normal! zE")

	for index, line in ipairs(lines) do
		if not in_mermaid and line:match("^%s*```%s*mermaid%s*$") then
			in_mermaid = true
			start_line = index
		elseif in_mermaid and line:match("^%s*```%s*$") then
			if start_line and index > start_line then
				vim.cmd(("%d,%dfold"):format(start_line, index))
				vim.cmd(("%dfoldclose"):format(start_line))
			end
			in_mermaid = false
			start_line = nil
		end
	end

	vim.api.nvim_win_set_cursor(0, cursor)
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "markdown",
	callback = function()
		vim.opt_local.foldmethod = "manual"
		vim.opt_local.foldopen:remove("insert")
		vim.schedule(fold_mermaid_blocks)
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave" }, {
	group = augroup,
	pattern = "markdown",
	callback = function()
		vim.schedule(fold_mermaid_blocks)
	end,
})
