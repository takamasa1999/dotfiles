return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			bash = { "shellcheck" },
		}
	end,
}
