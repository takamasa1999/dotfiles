-- count buffers via :ls (you mentioned API gives stale data on fast deletes)
local function count_loaded_buffers()
	local out = vim.api.nvim_exec2("ls", { output = true }).output
	local n = 0
	for _ in out:gmatch("[^\n]+") do
		n = n + 1
	end
	return n
end

local function is_no_name_buf()
	return (vim.api.nvim_buf_get_name(0) == "") and (vim.bo.buftype == "")
end

-- tiny actions (centralize force/non-force & modified checks)
local function close_buffer(force)
	if force then
		vim.cmd("bdelete!")
		return true
	end
	if vim.bo.modified then
		vim.notify("Buffer contains unsaved changes!", vim.log.levels.WARN)
		return false
	end
	vim.cmd("bdelete")
	return true
end

local function quit_neovim(force)
	vim.cmd(force and "qa!" or "qa")
end

local function is_single_window_multiple_tabs()
	return #vim.api.nvim_tabpage_list_wins(0) == 1 and #vim.api.nvim_list_tabpages() > 1
end

-- smart close: buffer > tab > neovim
local function smartclose(force)
	local buf_count = count_loaded_buffers()

	-- if is_single_window_multiple_tabs() then
	-- 	vim.cmd("tabclose")
	-- 	return
	-- end

	if buf_count > 1 or is_no_name_buf() == false then
		close_buffer(force)
		return
	end

	if force then
		quit_neovim(force)
	end
end

-- command (debug)
-- vim.api.nvim_create_user_command("CountLoadedBuffers", function()
-- 	print(count_loaded_buffers())
-- end, { desc = "list loaded buffers excluding deleted ones" })

-- keymaps
local set = vim.keymap.set
-- set({ "n", "i", "v", "c" }, "<C-q>", function()
-- 	smartclose(false)
-- end, { desc = "quit" })
-- set({ "n", "i", "v", "c" }, "<S-q>", function()
-- 	smartclose(true)
-- end, { desc = "force quit" })

-- Probably, I don't need this anyomore...
set({ "n", "i", "v", "c" }, "<C-q>",function ()
	smartclose(false)
end, { desc = "Buffer delete" })
set({ "n", "i", "v", "c" }, "<S-q>",function ()
	smartclose(true)
end, { desc = "Force buffer delete" })
