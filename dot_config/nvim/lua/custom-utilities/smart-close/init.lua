-- exec is used instead of bufs api to avoid the bug.
-- when buffers are quickly deleted the api tells you wrong information.
local function count_loaded_buffers()
	local buffers = vim.api.nvim_exec2("ls", { output = true }).output

	local count = 0
	for _ in buffers:gmatch("[^\n]+") do
		count = count + 1
	end

	return count
end

-- for debugging purposes
vim.api.nvim_create_user_command("CountLoadedBuffers", function()
	count_loaded_buffers()
end, { desc = "list loaded buffers excluding deleted ones" })

-- close things smartly as the order below
-- buffer > tab > neovim
local function smartclose(force)
	local win_count = #vim.api.nvim_tabpage_list_wins(0)
	local tab_count = #vim.api.nvim_list_tabpages()
	local buf_count = count_loaded_buffers()

	if win_count == 1 and tab_count > 1 then
		-- close the tab if it's the only window in it
		vim.cmd("tabclose")
		return
	end

	if buf_count > 1 then
		-- close just the buffer
		if force then
			vim.cmd("bdelete!")
		else
			if vim.bo.modified then
				vim.notify("Buffer contains unsaved changes!", vim.log.levels.WARN)
				return
			end
			vim.cmd("bdelete")
		end
		return
	end

	-- last buffer → quit neovim
	if force then
		vim.cmd("q!")
	else
		if vim.bo.modified then
			vim.notify("Buffer contains unsaved changes!", vim.log.levels.WARN)
			return
		end

		vim.cmd("q")
	end
end

local set = vim.keymap.set
set({ "n", "i", "v", "c" }, "<c-q>", function()
	smartclose(false)
end, { desc = "quit" })
set({ "n", "i", "v", "c" }, "<s-q>", function()
	smartclose(true)
end, { desc = "force quit" })
