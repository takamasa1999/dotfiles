-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP additional settings on top of lspconfig
local servers = {
	bashls = {
		filetypes = { "sh", "bash", "zsh" },
	},
	sourcekit = {},
	ltex_plus = {},
	lua_ls = {},
	marksman = {},
	basedpyright = {},
	pyright = {},
}
for name, config in pairs(servers) do
	-- local extended_config = vim.tbl_deep_extend("force", {}, {
	-- 	capabilities = capabilities,
	-- }, config)
	-- vim.lsp.config(name, extended_config)
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end
