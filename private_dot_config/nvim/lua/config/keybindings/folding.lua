local wk = require("which-key")

wk.add({
  { "<Space>", "za", desc = "Toggle fold", silent = true, nowait = true },
  { "<C-Space>", "zR", desc = "Unfold all", silent = true, nowait = true },
})
