return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      {
        mode = { "n", "x" },
        { "p", "<plug>(YankyPutAfter)", desc = "Paste after cursor" },
        { "P", "<plug>(YankyPutBefore)", desc = "Paste before cursor" },
        { "gp", "<plug>(YankyGPutAfter)", desc = "Globally paste after cursor" },
        { "gP", "<plug>(YankyGPutBefore)", desc = "Globally paste before cursor" },
      },
      {
        { "<leader>y", group = "Paste utils" },
        { "<leader>yn", "<plug>(YankyNextEntry)", desc = "Go to next yanky entry" },
        { "<leader>yp", "<plug>(YankyPreviousEntry)", desc = "Go to previous yanky entry" },
      },
    })
  end,
}
