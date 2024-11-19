local wk = require("which-key")

wk.add({
  { "<C-J>", "<C-W>j", desc = "Move to below window" },
  { "<C-K>", "<C-W>k", desc = "Move to above window" },
  { "<C-H>", "<C-W>h", desc = "Move to left window" },
  { "<C-L>", "<C-W>l", desc = "Move to right window" },
})
