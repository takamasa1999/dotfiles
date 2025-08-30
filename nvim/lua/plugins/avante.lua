-- https://github.com/yetone/avante.nvim
return {
	"yetone/avante.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"zbirenbaum/copilot.lua", -- for providers='copilot'
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		windows = {
			width = 50,
			input = {
				height = 11,
			},
		},
		selector = {
			exclude_auto_select = { "NvimTree" },
		},
		instructions_file = "avante.md",
		-- for example
		provider = "copilot",
		web_search_engine = {
			provider = "brave", -- tavily, serpapi, google, kagi, brave, or searxng
			proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
		},
	},
	keys = {
		{
			"<leader>a+",
			function()
				local tree_ext = require("avante.extensions.nvim_tree")
				tree_ext.add_file()
			end,
			desc = "Select file in NvimTree",
			ft = "NvimTree",
		},
		{
			"<leader>a-",
			function()
				local tree_ext = require("avante.extensions.nvim_tree")
				tree_ext.remove_file()
			end,
			desc = "Deselect file in NvimTree",
			ft = "NvimTree",
		},
	},
}
