return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  opts = {
    highlight = {
      -- Highlight background instead of foreground
      after = "bg",
      -- Custom highlight matching regex
      pattern = [[.*<(KEYWORDS)\s*]],
    },
    search = {
      -- Custom keywords matching regex
      pattern = [[\b(KEYWORDS)\b]],
    },
  },
}
