return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<leader><C-H>", "<cmd>Twilight<cr>", desc = "Toggle twilight (focus) mode" },
    })
  end,
}
