require("which-key").register({
    ["<C-n>"] = { ":NeoTreeShowToggle<CR>", "Toggle neo tree (files explorer)" },
    ["<C-g>"] = { ":Neotree float git_status<CR>", "Show git status explorer" },
}, {
    mode = "n",
})
