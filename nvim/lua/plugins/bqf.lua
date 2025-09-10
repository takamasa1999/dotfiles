return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	config = function()
		require("bqf").setup({
			preview = {
				winblend = 0,
				win_height = 100,
			},
		})
	end,
}
