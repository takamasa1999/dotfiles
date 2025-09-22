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
			dockerls = {},
			yamlls = {},
			texlab = {},
			-- docker_compose_language_service = {},
			-- docker_language_server = {},
		}
		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end

		-- LSP Keymaps (recommended convention)
		local set = vim.keymap.set

		-- Actions
		set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
		set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })

		-- Info
		set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover docs" })
		set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "LSP: Signature help" })

		-- Navigation
		set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
		set("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })
		set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: Implementation" })
		set("n", "gD", vim.lsp.buf.type_definition, { desc = "LSP: Type definition" })
		set("n", "gO", vim.lsp.buf.document_symbol, { desc = "LSP: Document symbols" })
		set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "LSP: Workspace symbols" })
	end,
}

return {
	lspconfig,
	lazydiv,
}
