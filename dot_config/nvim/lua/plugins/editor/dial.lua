-- https://github.com/monaqa/dial.nvim
return {
	"monaqa/dial.nvim",
	event = "VeryLazy",
	config = function()
		local augend = require("dial.augend")

		-- 増減対象（augends）の定義
		require("dial.config").augends:register_group({
			-- 通常モードで使う既定セット
			default = {
				augend.integer.alias.decimal, -- 10進整数  … 1, 2, 3
				augend.integer.alias.hex, -- 16進整数  … 0x0a → 0x0b
				augend.date.alias["%Y-%m-%d"], -- 日付     … 2025-10-10
				augend.semver.alias.semver, -- セマンティックバージョン … v1.2.3
				augend.constant.new({ -- 真偽値
					elements = { "true", "false" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({ -- on/off
					elements = { "on", "off" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({ -- よく使うログレベル例（お好みで）
					elements = { "trace", "debug", "info", "warn", "error", "fatal" },
					word = true,
					cyclic = true,
				}),
			},
		})

		local map = vim.keymap.set

		map("n", "<A-=>", function()
			require("dial.map").manipulate("increment", "normal")
		end)
		map("n", "<A-->", function()
			require("dial.map").manipulate("decrement", "normal")
		end)
		map("n", "g<A-=>", function()
			require("dial.map").manipulate("increment", "gnormal")
		end)
		map("n", "g<A-->", function()
			require("dial.map").manipulate("decrement", "gnormal")
		end)
		map("x", "<A-=>", function()
			require("dial.map").manipulate("increment", "visual")
		end)
		map("x", "<A-->", function()
			require("dial.map").manipulate("decrement", "visual")
		end)
		map("x", "g<A-=>", function()
			require("dial.map").manipulate("increment", "gvisual")
		end)
		map("x", "g<A-->", function()
			require("dial.map").manipulate("decrement", "gvisual")
		end)
	end,
}
