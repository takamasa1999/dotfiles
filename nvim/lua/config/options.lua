local o = vim.o
local op = vim.opt
local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

o.cursorline = true
o.cursorlineopt = "both"
o.shiftwidth = 4
o.tabstop = 4
o.clipboard = "unnamedplus"
o.winborder = "rounded"

op.number = true
op.relativenumber = true
op.termguicolors = true
op.ignorecase = true

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}
