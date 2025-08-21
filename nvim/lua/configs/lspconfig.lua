require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright",
    -- "typos_lsp", 
    "ltex_plus" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
