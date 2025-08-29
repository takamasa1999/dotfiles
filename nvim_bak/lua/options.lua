require "nvchad.options"

vim.opt.number = true
vim.opt.relativenumber = true

local function paste()
	return {
		vim.fn.split(vim.fn.getreg "", "\n"),
		vim.fn.getregtype "",
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy "+",
		["*"] = require("vim.ui.clipboard.osc52").copy "*",
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.shiftwidth = 4
o.tabstop = 4
o.clipboard = "unnamedplus"

-- local options = {
-- 	sources = {
-- 		{ name = "copilot" },
-- 	},
-- }
-- options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")
-- require("cmp").setup(options)
--

-- Load Theme after everything else is loaded. This ensures options are loaded first.
vim.cmd [[colorscheme tokyonight]]
