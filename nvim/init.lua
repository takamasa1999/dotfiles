vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- In this stage, plugins are loaded.
require("config.lazy")

require("custom_utilities.smartClose")

-- Additional configuration
require("config.options")
require("config.keymaps")
require ("config.clipboard")
