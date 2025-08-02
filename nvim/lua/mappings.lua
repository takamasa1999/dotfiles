require "nvchad.mappings"

local map = vim.keymap.set

vim.keymap.set({ "n", "t" }, "<C-t>", function()
	require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal" })

local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "telescope commands" })
vim.keymap.set("n", "<leader>fof", builtin.oldfiles, { desc = "telescope oldfiles" })

-- Find Old Word
vim.keymap.set("n", "<leader>fow", function()
	require("telescope").extensions.live_grep_oldfiles.find()
end, { desc = "telescope live grep old" })
