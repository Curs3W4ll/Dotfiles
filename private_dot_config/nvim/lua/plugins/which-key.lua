return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    preset = "modern",
    plugins = {
      spelling = {
        enabled = true,
      },
    },
    keys = {
      scroll_down = "<C-J>",
      scroll_up = "<C-K>",
    },
    win = {
      padding = { 0, 2 },
      wo = {
        winblend = 30,
      },
    },
    layout = {
      height = { min = 8, max = 20 },
    },
  },
}
