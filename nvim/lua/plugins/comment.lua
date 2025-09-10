-- https://github.com/numToStr/Comment.nvim
return {
	"numToStr/Comment.nvim",
	version = "0.8.0",
	opts = {
		-- add any options here
	},
	config = function()
		local api = require("Comment.api")
		local map = vim.keymap.set
		map("n", "<C-_>", api.toggle.linewise.current, { desc = "Toggle comment" })
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		-- Visual mode: keep selection
		map("x", "<C-_>", function()
			vim.api.nvim_feedkeys(esc, "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end)
	end,
}
