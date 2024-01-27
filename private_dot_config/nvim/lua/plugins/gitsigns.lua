return function()

    require("gitsigns").setup({
        -- Enable sign in left column
        signcolumn = true,
        -- Enable line numbers highlight
        numhl = true,
        -- Enable blame informations on current line
        current_line_blame = true,
        current_line_blame_opts = {
            -- Display blame informations after 500ms without the cursor moving
            delay = 500,
            -- Align blame informations to the right
            virt_text_pos = "eol",
        },
        -- Calling custom bindings when detecting a file using git
        on_attach = require("keybindings.gitsigns").git,
    })

end
