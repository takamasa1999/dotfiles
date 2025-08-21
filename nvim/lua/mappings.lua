require "nvchad.mappings"

local map = vim.keymap.set

map({ "n", "t" }, "<A-t>", function()
	require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal" })

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

-- in your on_attach(client, bufnr) function
-- local map = map
-- map('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: Rename symbol' })
--

map("n", "[d", function()
	vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Previous diagnostic (with float)" })

map("n", "]d", function()
	vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Next diagnostic (with float)" })

map("n", "ca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })
