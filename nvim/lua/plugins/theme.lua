return {
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Configure the light theme
			require("vscode").setup({
				style = "light",
			})

			-- Set the colorscheme
			vim.cmd.colorscheme("vscode")
		end,
	},
}
