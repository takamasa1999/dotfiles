-- https://github.com/zbirenbaum/copilot.lua
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<M-y>",
				accept_word = "<M-w>",
				accept_line = "<M-l>",
				next = "<M-n>",
				prev = "<M-p>",
				dismiss = "<M-x>",
			},
		},
		panel = { enabled = true },
		filetypes = {
			markdown = true,
			tex = true,
			-- ["*"] = false,
		},
	},
}
