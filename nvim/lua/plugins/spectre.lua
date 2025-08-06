-- https://github.com/nvim-pack/nvim-spectre
return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },   -- hard-requirement
    cmd = { "Spectre" },                          -- lazy-load on :Spectre
    keys = {
      { "<leader>sr", function() require("spectre").open() end,            desc = "Search (project)" },
      { "<leader>sf", function() require("spectre").open_file_search{select_word=true} end, desc = "Search (file)" },
      { "<leader>sw", function() require("spectre").open_visual{select_word=true} end, mode = "v", desc = "Search selection" },
    },
    opts = {
      open_cmd     = "noswapfile vnew",  -- put the panel in a vertical split
      live_update  = true,               -- re-run search when files are written
      is_insert_mode = false,            -- start in Normal for quick navigation
    },
  },
}
