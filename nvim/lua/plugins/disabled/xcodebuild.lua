return {
	"wojciech-kulik/xcodebuild.nvim",
	version = "6.4.0",
	dependencies = {
		-- Uncomment a picker that you want to use, snacks.nvim might be additionally
		-- useful to show previews and failing snapshots.
		-- You must select at least one:
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("xcodebuild").setup({
			-- put some options here or leave it empty to use default settings
		})
	end,
}
