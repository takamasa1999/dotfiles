local map = vim.keymap.set

-- General keymaps
map("n", "<leader>y", "<cmd>%y<cr>", { desc = "Yank this buffer" })

-- Save
map("n", "<leader> ", "<C-^>", { desc = "Switch to last buffer" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write buffer" })
map("n", "<leader>W", "<Cmd>wa<CR>", { desc = "Write all buffers" })
map("n", "<leader>sw", "<cmd>SudaWrite<CR>", { desc = "Sudo write buffer" })

map("n", "<leader>Q", "<Cmd>qa!<CR>", { desc = "Quit all" })

map("n", "<leader>tt", "<C-w>T", { desc = "Break out into a new tab" })

-- Pane navigations
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left pane" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to bottom pane" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to top pane" })
map("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right pane" })

-- Buffer navigations
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic (with float)" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic (with float)" })

-- Escape from terminal mode
map("t", "<A-n>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- Escape from search
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", { silent = true })

-- Search within selection
map("x", "/", "<Esc>/\\%V")

-- Utilities
map({ "n", "i", "x" }, "<A-t>", "<cmd>tabnew | terminal<cr>")
