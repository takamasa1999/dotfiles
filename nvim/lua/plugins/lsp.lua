local lsp_servers = { "lua_ls", "ltex_plus" }
return {
	-- https://github.com/neovim/nvim-lspconfig
	"neovim/nvim-lspconfig",
	dependencies = {
		-- https://github.com/mason-org/mason-lspconfig.nvim
		"mason-org/mason-lspconfig.nvim",
		'hrsh7th/cmp-nvim-lsp',
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = lsp_servers,
		})

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		lspconfig["sourcekit"].setup({
			capabilities = capabilities,
		})
	end
}
