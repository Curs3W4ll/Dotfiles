local wk = require("which-key")

wk.add({
  {
    "<leader><C-U>",
    "<cmd>Lazy update<cr><cmd>MasonUpdate<cr><cmd>MasonToolsUpdate<cr>",
    desc = "Update plugins and tools",
  },
  { "<leader><C-T>", "<cmd>Mason<cr>", desc = "Open Mason (tools manager)" },
  { "<leader><C-L>", "<cmd>Lazy<cr>", desc = "Open Lazy (plugins manager)" },
})
