-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#installation
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			modules = {},
			ensure_installed = { "c", "lua", "rust", "markdown", "markdown_inline" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			-- List of parsers to ignore installing (for "all")
			ignore_install = { "javascript" },

			highlight = {
				-- `false` will disable the whole extension
				-- enable = true,

				-- list of language that will be disabled
				-- disable = { "c", "rust" },

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
		})

		for _, query_path in ipairs(vim.api.nvim_get_runtime_file("queries/markdown/injections.scm", true)) do
			if not query_path:find("/lazy/nvim%-treesitter/", 1, false) then
				local query = table.concat(vim.fn.readfile(query_path), "\n")
				vim.treesitter.query.set("markdown", "injections", query)
				break
			end
		end
	end,
}
