local o = vim.o
local opt = vim.opt

o.cursorline = false
-- o.cursorlineopt = "both"
o.shiftwidth = 4
o.tabstop = 4
o.winborder = "rounded"
o.scrolloff = 999
o.showbreak = "↳ "
o.linebreak = true

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.ignorecase = false

opt.clipboard = "unnamedplus"
vim.g.clipboard = "osc52"

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		-- avoide opencode terminal to be applied
		if vim.bo.filetype == "opencode_terminal" then
			return
		end
		vim.opt_local.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.opt_local.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	callback = function()
		vim.opt_local.relativenumber = true
	end,
})
