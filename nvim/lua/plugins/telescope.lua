return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		-- https://github.com/nvim-lua/plenary.nvim
		"nvim-lua/plenary.nvim",
		-- https://github.com/nvim-telescope/telescope-project.nvim
		"nvim-telescope/telescope-project.nvim",
		-- https://github.com/incptr/telescope-live-grep-oldfiles.nvim
		"incptr/telescope-live-grep-oldfiles.nvim",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					prompt_position = "top",
					-- width = 0.95, height = 0.85,
				},
				sorting_strategy = "ascending",
			},
		})

		require("telescope").load_extension("project")
		require("telescope").load_extension("scope")
		require("telescope").load_extension("live_grep_oldfiles")
	end,
}
