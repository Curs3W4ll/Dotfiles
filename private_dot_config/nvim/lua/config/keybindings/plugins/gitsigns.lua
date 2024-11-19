return {
  setup = function(bufnbr)
    local wk = require("which-key")

    wk.add({
      buffer = bufnbr,
      { "<leader>g", group = "Git" },
      {
        "<leader>gv",
        "<cmd>Gitsigns toggle_linehl<cr><cmd>Gitsigns toggle_word_diff<cr><cmd>Gitsigns toggle_deleted<cr>",
        desc = "Toggle Git visual changes",
      },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Display hunk preview" },
      { "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", desc = "Toggle hunk stage status" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset file" },
      { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Go to next hunk" },
      { "<leader>gN", "<cmd>Gitsigns prev_hunk<cr>", desc = "Go to previous hunk" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Display file diff view" },
      { "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "Display file blame history" },
    })
  end,
}
