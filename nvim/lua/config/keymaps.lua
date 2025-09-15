-- Ptabnexerincipal. Keep it minimal. Add what you really use.
local map = vim.keymap.set

-- Save
map("n", "<A-Tab>", "<C-^>", { desc = "Switch to last buffer" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Write buffer" })
map("n", "<leader>S", "<cmd>SudaWrite<CR>", { desc = "Sudo write buffer" })
map("n", "<leader>Q", "<Cmd>qa!<CR>", { desc = "Quit all" })

-- Pane navigations
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left pane" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to bottom pane" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to top pane" })
map("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right pane" })

-- Tab navigations
-- map("n", "<Tab>", "<cmd>tabnext<cr>", { silent = true, desc = "Next tab" })
-- map("n", "<S-Tab>", "<cmd>tabprevious<cr>", { silent = true, desc = "Next tab" })
map("n", "<C-t>t", "<cmd>tabnew<cr>", { desc = "Break out into a new tab" })

-- Buffer navigations
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic (with float)" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic (with float)" })

-- Escape from terminal mode
-- joasdjfoasfjd
--
map("t", "<C-\\>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- Escape from search
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", { silent = true })

-- Search within selection
map("x", "/", "<Esc>/\\%V")

-- Utilities
map({ "n", "i", "x" }, "<A-t>", "<cmd>tabnew | terminal<cr>")
