return {
	"radioactivepb/smartclose.nvim",
	opts = {
		keybinds = {
			-- Smart close
			smartclose = "<C-q>",
			-- Smart close!
			smartclose_force = "<S-q>",
		},
		actions = {
			close_all = {
				empty = true,
				floating = false,
			},
		},
	},
}
-- return {}
