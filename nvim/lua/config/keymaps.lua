local keymap = vim.keymap.set

-- General keymaps
keymap("n", "<C-w>t", "<C-w>T", {
	desc = "Break out into a new tab",
})

-- Go to the latest buffer with <leader><Space>
keymap("n", "<C-Tab>", "<C-^>", { desc = "Switch to last buffer" })
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file" })
keymap("v", "<C-s>", "<Esc><cmd>w<CR>gv", { desc = "Save file" })
keymap("n", "<leader>Q", "<Cmd>qa!<CR>", { desc = "Quit all" })
keymap("n", "<leader>W", "<Cmd>wqa<CR>", { desc = "Save & quit all" })

-- Tab navigations
keymap("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
keymap("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })

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
keymap("n", "ca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Lsp rename" })

-- Format,
keymap("n", "<leader>fm", function()
	local conform = require("conform")
	conform.format({ async = true, lsp_format = "fallback" }, function(err, did_edit)
		if did_edit == true then
			vim.notify("Format Applied", vim.log.levels.INFO)
		end
		if err ~= nil then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end)
end, { desc = "Format buffer" })

-- Modify or disable mapping as per NvChad standards
keymap("t", "<C-x>", [[<C-\><C-n>]], { noremap = true, silent = true })
keymap("n", "<Esc>", "<Cmd>nohlsearch<CR>", { silent = true })

-- Mimic like nvchad's buffer close behavior
keymap("n", "<leader>x", function()
	local win_count = #vim.api.nvim_tabpage_list_wins(0)
	local tab_count = #vim.api.nvim_list_tabpages()

	if win_count == 1 and tab_count > 1 then
		vim.cmd("tabclose")
	else
		vim.cmd("bdelete")
	end
end, { desc = "Close buffer or tab" })

-- Search within selection
keymap("x", "/", "<Esc>/\\%V")
