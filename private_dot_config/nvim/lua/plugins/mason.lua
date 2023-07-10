return function()

    require("mason").setup({
        ui = {
            border = "rounded",
        },
        log_level = vim.log.levels.DEBUG,
    })

    -- Update mason registry
    require("mason-registry").update()

end
