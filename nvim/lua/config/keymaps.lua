local keymap = vim.keymap.set

-- General keymaps
keymap("n", "<C-w>t", "<C-w>T", {
	desc = "Break out into a new tab",
})
keymap("n", "<leader>y", "<cmd>%y<cr>", { desc = "Yank this buffer" })
keymap("n", "<leader>d", "<cmd>%d<cr>", { desc = "Yank this buffer" })

-- Go to the latest buffer with <leader><Space>
keymap("n", "<leader> ", "<C-^>", { desc = "Switch to last buffer" })
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file" })
keymap("v", "<C-s>", "<Esc><cmd>w<CR>gv", { desc = "Save file" })

keymap("n", "<leader>s", "<cmd>SudaWrite<CR>", { desc = "Save file as root" })

keymap("n", "<leader>Q", "<Cmd>qa!<CR>", { desc = "Quit all" })
keymap("n", "<leader>W", "<Cmd>wqa<CR>", { desc = "Save & quit all" })

-- Tab navigations
keymap("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
keymap("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
keymap("n", "<leader>tt", "<cmd>tab split<cr>", { desc = "Tab split" })

-- Pane navigations
keymap("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left pane" })
keymap("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to bottom pane" })
keymap("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to top pane" })
keymap("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right pane" })

-- Buffer navigations
keymap("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic (with float)" })
keymap("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic (with float)" })

-- LSP things
keymap("n", "ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Lsp rename" })

-- Modify or disable mapping as per NvChad standards
keymap("t", "<C-x>", [[<C-\><C-n>]], { noremap = true, silent = true })
keymap("n", "<Esc>", "<Cmd>nohlsearch<CR>", { silent = true })

-- Search within selection
keymap("x", "/", "<Esc>/\\%V")
