return {
	-- https://github.com/zbirenbaum/copilot.lua
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
		},
		panel = { enabled = true },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
