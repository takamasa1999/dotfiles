local augroup = vim.api.nvim_create_augroup("custom_markdown", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "markdown",
	callback = function()
		vim.opt_local.conceallevel = 2
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

-- markdown-preview.nvim settings
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 0
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_browser = ''
vim.g.mkdp_theme = 'light'
vim.g.mkdp_combine_preview = 0
vim.g.mkdp_combine_preview_auto_refresh = 1

vim.g.mkdp_preview_options = {
	mkit = {},
	katex = {},
	uml = {},
	maid = {},
	disable_sync_scroll = 0,
	sync_scroll_type = 'middle',
	hide_yaml_meta = 1,
	sequence_diagrams = {},
	flowchart_diagrams = {},
	content_editable = false,
	disable_filename = 0,
	toc = {}
}

