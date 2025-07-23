return {
  -- LSP Configuration & Server Setup
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and formatters
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- This is where you configure your LSP servers.
      --
      -- You can see a list of available servers here:
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      --
      -- And you can install them via Mason: `:Mason`

      -- Get the capabilities from nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Example of setting up lua_ls.
      -- Replace this with your own servers.
      require("lspconfig")["lua_ls"].setup({
        capabilities = capabilities,
      })

      -- Example for typescript server
      -- require('lspconfig')['tsserver'].setup({
      --   capabilities = capabilities,
      -- })

      -- Example for python server
      -- require('lspconfig')['pyright'].setup({
      --   capabilities = capabilities,
      -- })
    end,
  },

  -- Autocompletion Engine
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",   -- Buffer source
      "hrsh7th/cmp-path",     -- Path source
      "hrsh7th/cmp-cmdline",  -- Command line source

      -- Snippet engine and its source for nvim-cmp
      -- This setup uses vsnip.
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",

      -- To use an alternative snippet engine, comment out the vsnip plugins
      -- and uncomment the one you want to use below.

      -- For `luasnip`
      -- { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      -- "saadparwaiz1/cmp_luasnip",

      -- For `mini.snippets`
      -- "echasnovski/mini.snippets",
      -- "abeldekat/cmp-mini-snippets",

      -- For `ultisnips`
      -- "SirVer/ultisnips",
      -- "quangnguyen30192/cmp-nvim-ultisnips",

      -- For `snippy`
      -- "dcampos/nvim-snippy",
      -- "dcampos/cmp-snippy",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          -- You MUST specify a snippet engine.
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip`
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip`
            -- require('snippy').expand_snippet(args.body) -- For `snippy`
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips`
          end,
        },
        window = {
          -- You can add borders to the completion and documentation windows.
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item.
        }),
        -- The order of sources determines their priority.
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Use buffer source for `/` and `?` (search)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (command)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
