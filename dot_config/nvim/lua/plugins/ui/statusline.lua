-- https://github.com/nvim-lualine/lualine.nvim
return {
	"nvim-lualine/lualine.nvim",
	-- lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Mode is a filled block (hue shows on areas); normal is reversed for max contrast.
		local ink, sel, sub = "#141618", "#d0d0d0", "#e0e0e0"
		local function mode(bg, fg)
			return {
				a = { fg = fg or ink, bg = bg, gui = "bold" },
				b = { fg = ink, bg = sel },
				c = { fg = ink, bg = sub },
			}
		end
		local eink = {
			normal = mode("#141618", "#ffffff"),
			insert = mode("#74a0dc"),
			visual = mode("#dca574"),
			replace = mode("#dc7874"),
			command = mode("#dccb74"),
			inactive = {
				a = { fg = "#969696", bg = sub },
				b = { fg = "#969696", bg = sub },
				c = { fg = "#969696", bg = sub },
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				-- theme = "auto",
				theme = eink,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
					refresh_time = 16, -- ~60fps
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"CursorMoved",
						"CursorMovedI",
						"ModeChanged",
					},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
