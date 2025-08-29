return {
  "incptr/telescope-live-grep-oldfiles.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension "live_grep_oldfiles"
  end,
}
