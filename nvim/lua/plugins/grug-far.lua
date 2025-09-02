-- https://github.com/MagicDuck/grug-far.nvim
return {
	"MagicDuck/grug-far.nvim",
	version = "1.6.45",
	-- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
	-- additional lazy config to defer loading is not really needed...
	config = function()
		-- optional setup call to override plugin options
		-- alternatively you can set options with vim.g.grug_far = { ... }
		local grug_far = require("grug-far")
		grug_far.setup({
			-- options, see Configuration section below
			-- there are no required options atm
		})
		local keymap = vim.keymap.set
		keymap({ "n", "v" }, "<leader>fr", "<Cmd>GrugFarWithin<CR>", { desc = "Find and replace" })
	end,
}
