return function()

    local mason_tools = require("plugins.mason-tools")

    require("mason-tool-installer").setup({
        -- Ensure that wanted Mason tools are installed
        ensure_installed = mason_tools.list(),
        -- Automatically update Mason tools
        auto_update = true,
    })

end
