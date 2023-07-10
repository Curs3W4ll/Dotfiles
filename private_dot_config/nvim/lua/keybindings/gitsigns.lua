return function()

    local gs = package.loaded.gitsigns
    local wk = require("which-key")

    wk.register({
        g = {
            name = "Git",
            ["i"] = { ":Gitsigns toggle_linehl<CR>:Gitsigns toggle_word_diff<CR>", "Display more information about git changes" },
            ["p"] = { gs.preview_hunk, "Display hunk preview" },
            ["v"] = { gs.toggle_deleted, "Display git view of the code" },
            ["d"] = { gs.diffthis, "Display git diff about the current hunk" },
            ["r"] = { ":Gitsigns reset_hunk<CR>", "Reset hunk to the last added version in git" },
            ["R"] = { gs.reset_buffer, "Reset file to the last added version in git" },
            -- ================================
            -- ========== Navigation ==========
            -- ================================
            ["n"] = { function()
                if vim.wo.diff then
                    return "n"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, "Go to next hunk containing git modifications", expr = true },
            ["N"] = { function()
                if vim.wo.diff then
                    return "N"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, "Go to previous hunk containing git modifications", expr = true },
        },
    }, {
        mode = "n",
        prefix = "<leader>",
    })

end
