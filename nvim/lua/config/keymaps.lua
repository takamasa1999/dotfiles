local telescope_builtin = require("telescope.builtin")
local telescope_extensions = require("telescope").extensions
local map = vim.keymap.set

-- Telescope on project
map("n", "<leader>ff", telescope_builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fof", telescope_builtin.oldfiles, { desc = "Telescope oldfiles" })
map("n", "<leader>fog", function()
	telescope_extensions.live_grep_oldfiles.find()
end, { desc = "Telescope oldfiles live grep" })
map("n", "<leader>p", function()
	telescope_extensions.project.project({})
end, { desc = "Telescope project switcher" })
-- Telescope on buffers
map("n", "<leader>fbf", function()
	telescope_extensions.scope.buffers()
end, { desc = "Telescope buffer files" })
map("n", "<leader>fbg", function()
	telescope_builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Buffers",
	})
end, { desc = "Telescope buffer grep" })
-- Telescope additional
map("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>fc", telescope_builtin.commands, { desc = "Telescope commands" })

map("n", "<leader>gp", ":Neogit<CR>", { desc = "Git on project" })
map("n", "<leader>gf", ":NeogitLogCurrent<CR>", { desc = "Git on file" })

-- Utilities
map({ "n", "v" }, "<C-f>", ":GrugFarWithin<CR>", { desc = "Find and replace" })
map("n", "<localleader>p", ":MarkdownPreview<CR>", { desc = "Preview" })
-- map({ "n", "t", "i" }, "<A-t>", ":FloatermToggle<CR>", { desc = "Open terminal" })
map({ "n", "t" }, "<A-t>", "<cmd>ToggleTerm<CR>", { desc = "Toggle floating terminal" })
map("n", "<leader>r", ":RemoteStart<CR>", { desc = "Remote" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Half-page scroll then center cursor
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, center" })

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic (with float)" })

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic (with float)" })

map("n", "ca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })

map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })
map("n", "<leader>wq", ":wqa<CR>", { desc = "Save & quit all" })

-- Modify or disable mapping as per NvChad standards
map("t", "<C-x>", [[<C-\><C-n>]], { noremap = true, silent = true })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- Mimic like nvchad's buffer close behavior
map("n", "<leader>x", function()
	local win_count = #vim.api.nvim_tabpage_list_wins(0)
	local tab_count = #vim.api.nvim_list_tabpages()

	if win_count == 1 and tab_count > 1 then
		vim.cmd("tabclose")
	else
		vim.cmd("bdelete")
	end
end, { desc = "Close buffer or tab" })

map("n", "<leader>fm", function()
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

map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })

map("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Toggle comment" }
)
