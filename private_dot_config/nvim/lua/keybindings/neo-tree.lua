local wk = require("which-key")

wk.register({
    ["<C-n>"] = { ":Neotree reveal toggle left filesystem<CR>", "Toggle neo tree (files explorer)" },
    ["<C-g>"] = { ":Neotree toggle float git_status<CR>", "Show git status explorer" },
}, {
    mode = "n",
})
