-- https://github.com/yetone/avante.nvim
-- return {
-- 	-- https://github.com/yetone/avante.nvim
-- 	"yetone/avante.nvim",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"MunifTanjim/nui.nvim",
-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
-- 	},
-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
-- 	-- ⚠️ must add this setting! ! !
-- 	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
-- 		or "make",
-- 	event = "VeryLazy",
-- 	version = "0.0.27", -- Never set this value to "*"! Never!
-- 	---@module 'avante'
-- 	---@type avante.Config
-- 	opts = {
-- 		-- add any opts here
-- 		-- this file can contain specific instructions for your project
-- 		windows = {
-- 			width = 50,
-- 			input = {
-- 				height = 11,
-- 			},
-- 		},
-- 		selector = {
-- 			exclude_auto_select = { "NvimTree" },
-- 		},
--
-- 		instructions_file = "avante.md",
-- 		---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
-- 		---@type Provider
-- 		mode = "agentic",
-- 		provider = "copilot",
-- 		web_search_engine = {
-- 			provider = "brave", -- tavily, serpapi, google, kagi, brave, or searxng
-- 			proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
-- 		},
-- 		-- Safety settings to prevent modifications without permission
-- 		behaviour = {
-- 			auto_suggestions = false, -- Disable automatic suggestions
-- 			auto_set_filetype = false, -- Prevent automatic filetype changes
-- 			auto_apply_diff_after_generation = false, -- Require manual approval for applying changes
-- 			minimize_diff = false, -- Show full diff for review
-- 		},
-- 		hints = {
-- 			enabled = true, -- Show hints about what will be changed
-- 		},
-- 		-- Require explicit confirmation before making changes
-- 		auto_set_highlight = false,
-- 		diff = {
-- 			autojump = false, -- Don't automatically jump to diff locations
-- 			list_opener = "copen", -- Use quickfix list for reviewing changes
-- 		},
-- 	},
-- 	keys = {
-- 		{
-- 			"<leader>a+",
-- 			function()
-- 				local tree_ext = require("avante.extensions.nvim_tree")
-- 				tree_ext.add_file()
-- 			end,
-- 			desc = "Select file in NvimTree",
-- 			ft = "NvimTree",
-- 		},
-- 		{
-- 			"<leader>a-",
-- 			function()
-- 				local tree_ext = require("avante.extensions.nvim_tree")
-- 				tree_ext.remove_file()
-- 			end,
-- 			desc = "Deselect file in NvimTree",
-- 			ft = "NvimTree",
-- 		},
-- 	},
-- }

return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = "0.0.27", -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- for example
		provider = "copilot",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
			moonshot = {
				endpoint = "https://api.moonshot.ai/v1",
				model = "kimi-k2-0711-preview",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 32768,
				},
			},
		},
		web_search_engine = {
			provider = "brave", -- tavily, serpapi, google, kagi, brave, or searxng
			proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
		},
		windows = {
			width = 50,
			input = {
				height = 11,
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
