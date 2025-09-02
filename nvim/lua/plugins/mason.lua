local mason = {
	"mason-org/mason.nvim",
	opts = {},
}

-- Mason.nvim is a plugin manager for Neovim
local mason_tool_installer = {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- lsp
				"lua-language-server",
				"typos-lsp",
				"ltex-ls",
				"marksman",
				"pyright",
				"bash-language-server",
				-- "sourcekit",

				-- formatters
				"stylua",
				"prettier",
				"shfmt",
				"markdown-toc",

				-- linters
				"eslint_d",
			},
			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = 5, -- at least 5 hours between attempts
		})
	end,
}

return {
	mason,
	mason_tool_installer,
}
