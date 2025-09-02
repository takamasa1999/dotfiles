M = {}

local function list_loaded_unloaded_bufs()
	local all_buffers = vim.api.nvim_list_bufs()
	local selected = {}
	for _, buf in ipairs(all_buffers) do
		local isLoaded = vim.api.nvim_buf_is_loaded(buf)
		if isLoaded then
			table.insert(selected, buf)
		end
	end
	return selected
end

-- Close things smartly as the order below
-- Buffer > Tab > Neovim
local function smartClose(force)
	local win_count = #vim.api.nvim_tabpage_list_wins(0)
	local tab_count = #vim.api.nvim_list_tabpages()
	local buf_count = #list_loaded_unloaded_bufs()

	if win_count == 1 and tab_count > 1 then
		-- Close the tab if it's the only window in it
		vim.cmd("tabclose")
	elseif buf_count > 1 then
		-- Close just the buffer
		if force then
			vim.cmd("bdelete!")
		else
			vim.cmd("bdelete")
		end
	else
		-- Last buffer → quit Neovim
		if force then
			vim.cmd("qa!")
		else
			vim.cmd("qa")
		end
	end
end

local keymap = vim.keymap.set
keymap("n", "<C-q>", function()
	smartClose(false)
end, { desc = "Quit" })
keymap("n", "<S-q>", function()
	smartClose(true)
end, { desc = "Force Quit" })

M.smartClose = smartClose

return M
