local o = vim.o
local opt = vim.opt

o.cursorline = true
o.cursorlineopt = "both"
o.shiftwidth = 4
o.tabstop = 4
o.winborder = "rounded"
o.scrolloff = 999
o.showbreak = "↳ "
o.linebreak = true
-- o.background = "light"

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.ignorecase = false

opt.clipboard = "unnamedplus"
vim.g.clipboard = "osc52"
