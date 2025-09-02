-- https://github.com/lewis6991/gitsigns.nvim.git
return {
	"lewis6991/gitsigns.nvim",
	version = "1.0.2",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = { text = "‾" },
				changedelete = { text = "±" },
				untracked = { text = "?" },
			},
		})
		-- lsp_document_symbols
		local gs = require("gitsigns")
		local keymap = vim.keymap.set
		keymap("n", "<leader>gd", "<Cmd>Gitsigns diffthis<CR>", { desc = "Git this diff" })
		keymap("n", "[c", "<Cmd>Gitsigns nav_hunk prev<CR>", { desc = "Previous hunk" })
		keymap("n", "]c", "<Cmd>Gitsigns nav_hunk next<CR>", { desc = "Next hunk" })
		keymap("n", "gb", gs.blame_line, { desc = "Git blame line" })
		keymap("n", "<leader>gb", gs.blame, { desc = "Git blame file" })
		keymap("n", "gp", gs.preview_hunk, { desc = "Git preview hunk" })
	end,
}
