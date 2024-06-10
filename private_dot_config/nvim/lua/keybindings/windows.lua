local wk = require("which-key")

wk.register({
  w = {
    name = "Windows",
    m = {
      ":WindowsMaximize<CR>",
      "Maximize current window",
    },
    e = {
      ":WindowsEqualize<CR>",
      "Equalize all windows",
    },
    v = {
      ":WindowsMaximizeVertically<CR>",
      "Maximize current window vertically",
    },
    h = {
      ":WindowsMaximizeHorizontally<CR>",
      "Maximize current window horizontally",
    },
  },
}, {
  prefix = "<leader>",
})
