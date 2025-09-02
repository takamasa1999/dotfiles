-- https://github.com/nvim-telescope/telescope.nvim
return {
	"nvim-telescope/telescope.nvim",
	-- tag = "0.1.8",
	-- This is a temporary fix to prevent "vim.lsp.util.jump_to_location is deprecated". Refer to the link below.
	-- https://github.com/nvim-telescope/telescope.nvim/issues/3469
	commit = "b4da76be54691e854d3e0e02c36b0245f945c2c7",
	dependencies = {
		-- https://github.com/nvim-lua/plenary.nvim
		"nvim-lua/plenary.nvim",
		-- https://github.com/nvim-telescope/telescope-project.nvim
		-- "nvim-telescope/telescope-project.nvim",
		-- https://github.com/incptr/telescope-live-grep-oldfiles.nvim
		"incptr/telescope-live-grep-oldfiles.nvim",
		-- https://github.com/tiagovla/scope.nvim
		-- "tiagovla/scope.nvim",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					prompt_position = "top",
					width = 0.95,
					height = 0.95,
					preview_width = 0.6,
				},
				sorting_strategy = "ascending",
				wrap_results = true,
			},
			mappings = {
				["d"] = require("telescope.actions").delete_buffer,
			}
		})

		-- Wrap text on the preview window
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function()
				vim.wo.wrap = true
			end,
		})

		-- require("telescope").load_extension("project")
		-- require("telescope").load_extension("scope")
		require("telescope").load_extension("live_grep_oldfiles")

		-- Keymaps
		local builtin = require("telescope.builtin")
		local extensions = require("telescope").extensions
		local keymap = vim.keymap.set
		keymap("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		keymap("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		keymap("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		keymap("n", "<leader>fc", builtin.commands, { desc = "Telescope commands" })
		keymap("n", "<leader>fbf", builtin.buffers, { desc = "Telescope buffer files" })
		keymap(
			"n",
			"<C-b>",
			"<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal<cr>",
			{ desc = "Telescope buffer files" }
		)
		keymap("n", "<leader>fbg", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Buffers",
			})
		end, { desc = "Telescope buffer grep" })
		keymap("n", "<leader>fof", builtin.oldfiles, { desc = "Telescope oldfiles" })
		keymap("n", "<leader>fog", extensions.live_grep_oldfiles.find, { desc = "Telescope oldfiles live grep" })
		-- keymap("n", "<leader>fp", extensions.project.project, { desc = "Telescope project switcher" })
		keymap("n", "gd", builtin.lsp_definitions, { desc = "Go to lsp definition" })
		keymap("n", "gr", builtin.lsp_references, { desc = "Go to lsp references" })
		keymap("n", "gi", builtin.lsp_implementations, { desc = "Go to lsp implementations" })
		keymap("n", "gD", builtin.lsp_type_definitions, { desc = "Go to lsp type definitions" })
		keymap("n", "gs", builtin.lsp_document_symbols, { desc = "Go to lsp document symbols" })
	end,
}
