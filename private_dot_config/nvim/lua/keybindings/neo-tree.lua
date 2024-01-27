local wk = require("which-key")

wk.register({
    ["<C-n>"] = { ":Neotree show toggle<CR>", "Toggle neo tree (files explorer)" },
    ["<C-g>"] = { ":Neotree float git_status<CR>", "Show git status explorer" },
}, {
    mode = "n",
})
