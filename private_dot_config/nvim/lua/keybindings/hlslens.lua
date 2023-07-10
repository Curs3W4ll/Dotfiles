local wk = require("which-key")

wk.register({
    n = { "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", "Go to next searched" },
    N = { "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", "Go to previous searched" },
    ["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", "Search current word" },
    ["#"] = { "*<Cmd>lua require('hlslens').start()<CR>", "Search current word" },
    ["g*"] = { "g*<Cmd>lua require('hlslens').start()<CR>", "Search containing current word" },
    ["g#"] = { "g#<Cmd>lua require('hlslens').start()<CR>", "Search containing current word" },
}, {
    mode = "n",
    opts = {
        noremap = true,
        silent = true,
    },
})
