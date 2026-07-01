return {
	"mbbill/undotree",
	config = function()
		local map = vim.keymap.set
		map("n", "<A-u>", ":UndotreeToggle<CR>", { desc = "Toggle Undotree" })
	end,
}
