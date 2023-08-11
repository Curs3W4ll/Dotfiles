local wk = require("which-key")

wk.register({
    ["<C-t>"] = { "<Cmd>Lspsaga term_toggle<CR>", "Opens a terminal floating window" },
}, {
    mode = { "n", "t" },
})
