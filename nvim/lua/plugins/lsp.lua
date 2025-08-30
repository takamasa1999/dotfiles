local lazydiv = {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files ft=file type
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}

return {
	{
		"neovim/nvim-lspconfig",
	},
	lazydiv,
}
