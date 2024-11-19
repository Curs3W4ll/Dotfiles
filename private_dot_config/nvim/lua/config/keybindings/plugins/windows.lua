return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>w", group = "Windows" },
      { "<leader>wm", "<cmd>WindowsMaximize<cr>", desc = "Maximize current window" },
      { "<leader>we", "<cmd>WindowsEqualize<cr>", desc = "Equalize all windows" },
      { "<leader>wv", "<cmd>WindowsMaximizeVertically<cr>", desc = "Maximize current window vertically" },
      { "<leader>wh", "<cmd>WindowsMaximizeHorizontally<cr>", desc = "Maximize current window horizontally" },
    })
  end,
}
