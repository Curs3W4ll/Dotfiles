return {
    markdown = function()
        local wk = require("which-key")

        wk.register({
            m = {
                name = "Markdown preview",
                ["o"] = { ":lua require('peek').open()<CR>", "Open mk preview window" },
                ["c"] = { ":lua require('peek').close()<CR>", "Close mk preview window" },
            },
        }, {
            mode = "n",
            prefix = "<leader>",
        })
    end,
}
