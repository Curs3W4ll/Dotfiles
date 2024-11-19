return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      {
        "<C-T>",
        "<cmd>Lspsaga term_toggle<cr>",
        mode = { "n", "i", "v", "t" },
        desc = "Toggle terminal floating",
      },
    })
  end,
}
