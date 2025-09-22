return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	tag = "v2.16", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_syntax_conceal_disable = 1
		vim.g.vimtex_syntax_enabled = 0
	end,
}
