local wk = require("which-key")

wk.register({
  ["<C-t>"] = { ":Twilight<CR>", "Toggle twilight (focus) mode" },
}, {
  mode = "n",
  prefix = "<leader>",
})
