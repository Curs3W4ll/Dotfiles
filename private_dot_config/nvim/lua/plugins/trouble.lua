return function()

    require("trouble").setup({
        -- Close the window automatically when list is empty
        auto_close = true,
        -- Use signs defined by the lsp
        use_diagnostic_signs = true,
    })

end
