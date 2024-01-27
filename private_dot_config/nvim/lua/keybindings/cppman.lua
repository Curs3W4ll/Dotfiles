local wk = require("which-key")
local cppman = require("cppman")

wk.register({
    co = { function() cppman.input() end, "Open CPPMan search (cppreference.com)" },
}, {
    prefix = "<leader>",
})

return {
    cpp = function()
        wk.register({
            ["c<Enter>"] = { function() cppman.open_cppman_for(vim.fn.expand("<cword>")) end, "Search in CPPMan for word under cursor" },
        }, {
            prefix = "<leader>",
        })
    end,
    cppman = function()
        wk.register({
            ["<Enter>"] = { "K", "Search in CPPMan for word under cursor" },
            ["<BackSpace>"] = { "<C-T>", "Go back to previous page opened in CPPMan" },
        }, {
            mode = "n",
            nowait = true,
            noremap = false,
            silent = true,
        })
    end,
}
