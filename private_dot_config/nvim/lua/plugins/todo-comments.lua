return function()

    require("todo-comments").setup({
        highlight = {
            -- Highlight background instead of foreground
            after = "bg",
            -- Custom highlight matching regex
            pattern = [[.*<(KEYWORDS)\s*]],
        },
        search = {
            -- Custom keywords matching regex
            pattern = [[\b(KEYWORDS)\b]],
        },
    })

end
