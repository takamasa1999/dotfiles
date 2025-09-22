return {
	"xuhdev/vim-latex-live-preview",
	cmd = { "LLPStartPreview", "LLPStopPreview" },
	ft = "tex", -- load only for LaTeX files
	-- init = function()
		-- Viewer to open the PDF
		-- vim.givepreview_previewer = "okular"

		-- LaTeX engine
		-- vim.g.livepreview_engine = "pdflatex" -- could also use "xelatex" or "lualatex"

		-- Optional: use biber instead of bibtex
		-- vim.g.livepreview_use_biber = 1

		-- Optional: avoid recompile on every CursorHold
		-- vim.g.livepreview_cursorhold_recompile = 0
	-- end,
}
