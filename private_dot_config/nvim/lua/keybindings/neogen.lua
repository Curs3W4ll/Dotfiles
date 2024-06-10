local wk = require("which-key")
local neogen = require("neogen")

wk.register({
  D = {
    neogen.generate,
    "Generate code documentation",
  },
}, {
  prefix = "<leader>",
})
