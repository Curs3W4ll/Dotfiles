return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>D", "<cmd>Neogen<cr>", desc = "Generate code documentation" },
    })
  end,
}
