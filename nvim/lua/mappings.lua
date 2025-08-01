require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Telescope commands" })
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live_grep" })
vim.keymap.set("n", "<leader>fof", builtin.oldfiles, { desc = "Telescope oldfiles" })

-- Find Old Word
vim.keymap.set("n", "<leader>fow", function()
  require("telescope").extensions.live_grep_oldfiles.find()
end, { desc = "Live grep over oldfiles" })
