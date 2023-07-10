return function()

    -- TODO: See https://github.com/terrortylor/nvim-comment for integration with ts-comment
    require("nvim_comment").setup({
        -- Do not comment empty lines
        comment_empty = false,
        -- Do not create default mappings
        create_mappings = false,
    })

end
