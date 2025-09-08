-- https://github.com/NeogitOrg/neogit
return {
	"NeogitOrg/neogit",
	-- version = "2.0.0",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		-- Only one of these is needed.
		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		local keymap = vim.keymap.set
		keymap("n", "<leader>gp", "<Cmd>Neogit<CR>", { desc = "Git project management" })
		local neogit = require("neogit")
		neogit.setup({})
	end,
}
