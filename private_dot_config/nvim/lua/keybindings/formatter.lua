local wk = require("which-key")

wk.register({
  ["<C-f>"] = { ":FormatLock<CR>", "Format code of the current buffer" },
}, {
  mode = "n",
})
