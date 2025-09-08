-- https://github.com/Saghen/blink.cmp?tab=readme-ov-file
return {
	"saghen/blink.cmp",
	-- https://github.com/fang2hou/blink-copilot
	dependencies = {
		"fang2hou/blink-copilot",
		"rafamadriz/friendly-snippets",
	},
	-- optional = true,

	version = "1.6.0",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
			["<C-n>"] = { "show", "select_next", "fallback_to_mappings" },
		},

		-- auto_show = true,
		appearance = {
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 0 },
			trigger = {
				show_on_insert = false,
			},
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
			menu = {
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" }, -- Show "LSP", "Buffer", "Copilot", etc.
					},
				},
			},
		},

		cmdline = {
			keymap = { preset = "inherit" },
			completion = {
				menu = { auto_show = true },
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"copilot",
				"snippets",
				"buffer",
			},
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
