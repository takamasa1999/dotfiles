-- Tuned for Bigme B13 (Color E-ink): hue survives only on filled areas, so
-- text is distinguished by gray/bold/italic and hue is reserved for backgrounds.
return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local ink, white, dark = "#141618", "#ffffff", "#2a2a2a"
		local sel, sub = "#d0d0d0", "#e0e0e0"

		require("cyberdream").setup({
			variant = "light",
			italic_comments = true,
			colors = {
				light = {
					grey = "#969696",
					bg_alt = sub,
					bg_highlight = sel,
					-- Text hues at equal perceived lightness (~85/255): bright hues render as pale
					-- as comments on this panel, which flattens the hierarchy.
					blue = "#054bc3",
					purple = "#7606d9",
					magenta = "#9d0488",
					pink = "#ab043c",
					red = "#a81a04",
					orange = "#884203",
					yellow = "#6b5103",
					green = "#03631b",
					cyan = "#035c73",
				},
			},
			overrides = function(c)
				return {
					Comment = { fg = c.grey, italic = true },
					Keyword = { fg = c.orange, bold = true },
					Statement = { fg = c.magenta, bold = true },
					Function = { fg = c.blue, bold = true },
					CursorLine = { bg = sub },
					Visual = { bg = sel },
					Search = { fg = ink, bg = "#dccb74" },
					IncSearch = { fg = white, bg = dark, bold = true },
					CurSearch = { fg = white, bg = dark, bold = true },
					DiffAdd = { bg = "#90df9d" },
					DiffDelete = { bg = "#df9390" },
					DiffChange = { bg = sub },
					DiffText = { fg = white, bg = dark, bold = true },
					TelescopeSelection = { bg = sel, bold = true },
					-- floats need a filled area and a dark thin border to stand out from the page
					NormalFloat = { fg = ink, bg = sub },
					Pmenu = { fg = ink, bg = sub },
					FloatBorder = { fg = "#787878", bg = sub },
					TelescopeBorder = { fg = "#787878" },
					MatchParen = { fg = ink, bg = "#bebebe", bold = true },
					LineNr = { fg = c.grey },
					CursorLineNr = { fg = ink, bold = true },
					WinSeparator = { fg = "#787878" },
					IblScope = { fg = "#787878" },
					ColorColumn = { bg = sub },
					PmenuSel = { fg = ink, bg = sel, bold = true },
					-- severity by weight, not hue
					DiagnosticError = { fg = ink, bold = true },
					DiagnosticWarn = { fg = ink },
					DiagnosticInfo = { fg = "#787878" },
					DiagnosticHint = { fg = c.grey, italic = true },
					GitSignsAdd = { fg = ink, bold = true },
					GitSignsChange = { fg = ink, bold = true },
					GitSignsDelete = { fg = ink, bold = true },
				}
			end,
		})

		vim.cmd.colorscheme("cyberdream-light")
	end,
}
