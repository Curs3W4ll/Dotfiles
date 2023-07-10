local wk = require("which-key")

wk.register({
    t = {
        name = "Todos",
        -- ================================
        -- ========= Todos display ========
        -- ================================
        ["l"] = { ":TodoLocList<CR>", "Open todos list in a location window"},
        ["q"] = { ":TodoQuickFix<CR>", "Open todos list in a quickfix window"},
        ["t"] = { ":TodoTelescope<CR>", "Open todos list in a telescope window"},
        ["r"] = { ":TodoTrouble<CR>", "Open todos list in a trouble window"},
        -- ================================
        -- ======= Todos navigation =======
        -- ================================
        ["n"] = { function()
            require("todo-comments").jump_next()
        end, "Jump to next todo"},
        ["N"] = { function()
            require("todo-comments").jump_prev()
        end, "Jump to previous todo"},
    },
}, {
    mode = "n",
    prefix = "<leader>",
})
