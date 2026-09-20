-- https://github.com/akinsho/bufferline.nvim?tab=readme-ov-file#tabs
return {
	"akinsho/bufferline.nvim",
	version = "4.9.1",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		-- Check help with :h bufferline-configuration

		-- Selected tab is reversed; every derived group must be set or it keeps a
		-- white patch inside the dark tab.
		local ink, white, fill, tab = "#141618", "#ffffff", "#d0d0d0", "#e0e0e0"
		local names = {
			"trunc_marker", "fill", "group_separator", "group_label", "tab", "tab_selected", "tab_close",
			"close_button", "close_button_visible", "close_button_selected", "background",
			"buffer_visible", "buffer_selected", "numbers", "numbers_selected", "numbers_visible",
			"diagnostic", "diagnostic_visible", "diagnostic_selected", "hint", "hint_visible",
			"hint_selected", "hint_diagnostic", "hint_diagnostic_visible", "hint_diagnostic_selected",
			"info", "info_visible", "info_selected", "info_diagnostic", "info_diagnostic_visible",
			"info_diagnostic_selected", "warning", "warning_visible", "warning_selected",
			"warning_diagnostic", "warning_diagnostic_visible", "warning_diagnostic_selected",
			"error", "error_visible", "error_selected", "error_diagnostic", "error_diagnostic_visible",
			"error_diagnostic_selected", "modified", "modified_visible", "modified_selected",
			"duplicate", "duplicate_visible", "duplicate_selected", "separator", "separator_visible",
			"separator_selected", "tab_separator", "tab_separator_selected", "indicator_visible",
			"indicator_selected", "pick", "pick_visible", "pick_selected", "offset_separator",
		}
		local highlights = {}
		for _, name in ipairs(names) do
			local selected = name:find("selected") ~= nil
			if name == "fill" then
				highlights[name] = { bg = fill }
			elseif name:find("separator") or name == "trunc_marker" then
				highlights[name] = { fg = fill, bg = selected and ink or tab }
			elseif selected then
				highlights[name] = { fg = white, bg = ink, bold = true, italic = false }
			else
				highlights[name] = { fg = ink, bg = tab }
			end
		end

		local bufferline = require("bufferline")
		bufferline.setup({
			highlights = highlights,
			options = {
				mode = "tabs",
				separator_style = "slant",
				-- offsets = {
				-- 	{
				-- 		filetype = "NvimTree",
				-- 		text = "File Explorer",
				-- 		text_align = "center",
				-- 		separator = true,
				-- 	},
				-- },
				show_buffer_close_icons = false,
				show_close_icon = false,
				-- always_show_bufferline = true,
				-- show_tab_indicators = true,
				--
				-- enforce_regular_tabs = true,
				-- persist_buffer_sort = false,
			},
		})
	end,
}
