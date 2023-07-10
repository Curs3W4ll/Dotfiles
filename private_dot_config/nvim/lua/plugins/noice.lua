return function()

    require("noice").setup({
        lsp = {
            -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                  -- Override the default lsp markdown formatter with Noice
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  -- Override the lsp markdown formatter with Noice
                  ["vim.lsp.util.stylize_markdown"] = true,
                  -- Override cmp documentation with Noice (needs the other options to work)
                  ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            -- Position the cmdline and popupmenu together
            command_palette = true,
            -- Long messages will be sent to a split
            long_message_to_split = true,
            -- Enables an input dialog for inc-rename.nvim
            inc_rename = true,
        },
        messages = {
            -- Use mini view for default messages
            view = "mini",
            -- Use notify view for error messages
            view_error = "notify",
            -- Use notify view for warning messages
            view_warn = "notify",
            -- Use notify view for history messages (:messages)
            view_history = "notify",
            -- Use notify view for searching
            view_search = "mini",
        },
        -- Use noice for default vim.notify function
        notify = {
            enabled = true,
            -- Use notify view
            view = "notify",
        },
    })

end
