local wk = require("which-key")

wk.register({
    f = { ":FormatLock<CR>", "Format code of the current buffer" },
    F = { ":FormatWriteLock<CR>", "Format and write code of the current buffer" },
}, {
    mode = "n",
    prefix = "<leader>",
})
