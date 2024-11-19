return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<C-N>", "<cmd>Neotree reveal toggle left filesystem<cr>", desc = "Toggle file explorer" },
      { "<C-G>", "<cmd>Neotree toggle float git_status<cr>", desc = "Toggle git status explorer" },
    })
  end,
}
