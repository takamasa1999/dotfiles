-- https://github.com/iamcco/markdown-preview.nvim
-- return {
-- 	"iamcco/markdown-preview.nvim",
-- 	version = "0.0.10",
-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
-- 	build = "cd app && npm install",
-- 	init = function()
-- 		vim.g.mkdp_filetypes = { "markdown" }
-- 	end,
-- 	ft = { "markdown" },
-- 	config = function()
-- 		local keymap = vim.keymap.set
-- 		keymap("n", "<localleader>p", "<Cmd>MarkdownPreview<CR>", { desc = "Preview Markdown" })
-- 	end,
-- }
return {
  "selimacerbas/markdown-preview.nvim",
  dependencies = { "selimacerbas/live-server.nvim" },
  config = function()
    require("markdown_preview").setup({
      -- all optional; sane defaults shown
      instance_mode = "takeover",  -- "takeover" (one tab) or "multi" (tab per instance)
      port = 0,                    -- 0 = auto (8421 for takeover, OS-assigned for multi)
      open_browser = true,
      debounce_ms = 300,
	  mermaid_renderer = "js",
    })
  end,
}
