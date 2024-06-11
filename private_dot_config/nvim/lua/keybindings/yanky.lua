local wk = require("which-key")

wk.register({
  p = {
    "<Plug>(YankyPutAfter)",
    "Paste after cursor",
  },
  P = {
    "<Plug>(YankyPutBefore)",
    "Paste before cursor",
  },
  gp = {
    "<Plug>(YankyGPutAfter)",
    "Globally paste after cursor",
  },
  gP = {
    "<Plug>(YankyGPutBefore)",
    "Globally paste before cursor",
  },
}, {
  model = "nx",
})

wk.register({
  y = {
    name = "Paste utils",
    p = {
      "<Plug>(YankyPreviousEntry)",
      "Go to previous yanky entry",
    },
    n = {
      "<Plug>(YankyNextEntry)",
      "Go to next yanky entry",
    },
  },
}, {
  model = "n",
  prefix = "<leader>",
})
