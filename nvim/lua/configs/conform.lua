local options = {
  -- Experimental implementation. Doesn't work.
  -- formatters = {
  --   markdown_toc = {
  --     command = "markdown-toc",
  --     args = { "-i", "$FILENAME" },
  --   },
  -- },
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier", "markdown_toc" },
  },

  format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- markdown = { "markdown_toc" },
  },
}

return options
