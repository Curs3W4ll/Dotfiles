local wk = require("which-key")

wk.register({
    ["<space>"] = { ":CommentToggle<CR>", "Comment the cursor line" },
}, {
    mode = "n",
    prefix = "<leader>",
})

wk.register({
    ["<space>"] = { ":CommentToggle<CR>", "Comment the selection" },
}, {
    mode = "v",
    prefix = "<leader>",
})
