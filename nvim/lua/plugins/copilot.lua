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
				accept = "<Right>",
				accept_word = "<C-Right>",
				accept_line = "<Down>",
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
