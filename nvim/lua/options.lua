require "nvchad.options"

-- vim.opt.spell = true
-- vim.opt.spelllang = { "en_us" }

vim.opt.number = true
vim.opt.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4


-- Clipboard settings
vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

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


local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
