-- https://github.com/iamcco/markdown-preview.nvim
return {
	"iamcco/markdown-preview.nvim",
	version = "0.0.10",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	config = function()
		local keymap = vim.keymap.set
		keymap("n", "<localleader>p", "<Cmd>MarkdownPreview<CR>", { desc = "Preview Markdown" })
	end,
}
