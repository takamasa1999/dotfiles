require "nvchad.mappings"

local map = vim.keymap.set

map({ "n", "t" }, "<A-t>", function()
	vim.cmd "tabnew | terminal"
end, { desc = "Open terminal in new tab" })

local builtin = require "telescope.builtin"
map("n", "<leader>fc", builtin.commands, { desc = "telescope commands" })
map("n", "<leader>fof", builtin.oldfiles, { desc = "telescope oldfiles" })

-- Find Old Word
map("n", "<leader>fow", function()
	require("telescope").extensions.live_grep_oldfiles.find()
end, { desc = "telescope live grep old" })

-- Half-page scroll then center cursor
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, center" })

map("n", "[d", function()
	vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Previous diagnostic (with float)" })

map("n", "]d", function()
	vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Next diagnostic (with float)" })

map("n", "ca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })

map("n", "<leader>Q", ":qa!<CR>", { desc = "force quit all" })
map("n", "<leader>WQ", ":wqa<CR>", { desc = "save & quit all" })
