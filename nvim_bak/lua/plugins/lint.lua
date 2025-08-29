-- https://github.com/mfussenegger/nvim-lint
return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile", "InsertLeave" },
		config = function()
			local lint = require "lint"

			lint.linters_by_ft = {
				python = { "pylint" },
				html = { "htmlhint" },
				bash = { "shellcheck" },
				javascript = { "biomejs" },
				typescript = { "biomejs" },
			}

			local grp = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = grp,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.api.nvim_create_user_command("Lint", function()
				lint.try_lint()
			end, {})
		end,
	},
}
