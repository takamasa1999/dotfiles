local keymap = vim.keymap.set

keymap("n", "<leader>fm", function()
	local conform = require("conform")
	conform.format({ async = true, lsp_format = "fallback" }, function(err, did_edit)
		if did_edit == true then
			vim.notify("Format Applied", vim.log.levels.INFO)
		end
		if err ~= nil then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end)
end, { desc = "Format buffer" })
