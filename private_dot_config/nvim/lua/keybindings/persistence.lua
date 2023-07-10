local wk = require("which-key")

wk.register({
    s = {
        name = "Sessions",
        ["d"] = { ":lua require('persistence').load()<CR>", "Load last saved session for this directory"},
        ["l"] = { ":lua require('persistence').load({ last = true })<CR>", "Load last saved session overall"},
    },
}, {
    mode = "n",
    prefix = "<leader>",
})
