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

return {
	count_loaded_buffers,
}
