local lazydiv = {
	"folke/lazydev.nvim",
	version = "1.9.0",
	ft = "lua", -- only load on lua files ft=file type
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}

-- https://github.com/neovim/nvim-lspconfig
local lspconfig = {
	"neovim/nvim-lspconfig",
	version = "2.4.0",
	config = function()
		local servers = {
			typos_lsp = {},
			ltex_plus = {},
			bashls = {
				filetypes = { "sh", "bash", "zsh" },
			},
			sourcekit = {},
			lua_ls = {},
			systemd_ls = {},
			marksman = {},
			basedpyright = {},
			pyright = {},
		}
		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end
	end,
}

return {
	lspconfig,
	lazydiv,
}
