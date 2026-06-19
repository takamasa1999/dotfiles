-- https://github.com/3rd/diagram.nvim
return {
	"3rd/diagram.nvim",
	ft = { "markdown" },
	dependencies = {
		"3rd/image.nvim",
	},
	config = function()
		require("diagram").setup({
			integrations = {
				require("diagram.integrations.markdown"),
			},
			events = {
				render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
				clear_buffer = { "BufLeave" },
			},
			renderer_options = {
				mermaid = {
					background = nil, -- nil | "transparent" | "white" | "#hex"
					theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
					scale = 1, -- nil | 1 (default) | 2  | 3 | ...
					width = nil, -- nil | 800 | 400 | ...
					height = nil, -- nil | 600 | 300 | ...
					cli_args = nil, -- nil | { "--no-sandbox" } | { "-p", "/path/to/puppeteer" } | ...
				},
				-- mermaid = {
				-- 	background = "transparent",
				-- 	theme = "default",
				-- 	scale = 2,
				-- 	width = 2400,
				-- 	height = 1600,
				-- 	cli_args = { "-p", vim.fn.stdpath("config") .. "/mermaid-puppeteer.json" },
				-- },
			},
		})

		local augroup = vim.api.nvim_create_augroup("custom_diagram_render", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
			group = augroup,
			pattern = "markdown",
			callback = function()
				vim.defer_fn(function()
					pcall(require("diagram").render)
				end, 100)
			end,
		})
	end,
	keys = {
		{
			"<localleader>d",
			function()
				require("diagram").show_diagram_hover()
			end,
			mode = "n",
			ft = { "markdown" },
			desc = "Show diagram",
		},
	},
}
