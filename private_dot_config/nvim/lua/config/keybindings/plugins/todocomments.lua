return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>t", group = "Todos" },
      {
        "<leader>tn",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Jump to next todo",
      },
      {
        "<leader>tN",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Jump to previous todo",
      },
      { "<leader>tl", "<cmd>TodoTelescope<cr>", desc = "List todos" },
    })
  end,
}
