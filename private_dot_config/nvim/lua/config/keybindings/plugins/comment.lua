return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<leader><Space>", "<cmd>CommentToggle<cr>", desc = "Comment cursor line" },
      { "<leader><Space>", ":CommentToggle<cr>", mode = "v", desc = "Comment selection" },
    })
  end,
}
