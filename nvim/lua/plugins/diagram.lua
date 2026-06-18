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
					background = "transparent",
					theme = "default",
					scale = 2,
					cli_args = { "-p", vim.fn.stdpath("config") .. "/mermaid-puppeteer.json" },
				},
			},
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
