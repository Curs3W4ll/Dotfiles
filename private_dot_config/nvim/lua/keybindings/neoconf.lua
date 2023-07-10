local wk = require("which-key")

wk.register({
    e = {
        name = "Neoconf",
        ["s"] = { ":Neoconf<CR>", "Show local and global settings" },
        ["l"] = { ":Neoconf local<CR>", "Show only local settings" },
        ["g"] = { ":Neoconf global<CR>", "Show global settings" },
        ["dc"] = { ":Neoconf show<CR>", "Show diff of merged configs" },
        ["dl"] = { ":Neoconf lsp<CR>", "Show diff of merged lsp configs" },
    },
}, {
    mode = "n",
    prefix = "<leader>",
})
