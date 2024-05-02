return function()

    require("mason-lspconfig").setup({
        handlers = {
            -- Comes from https://github.com/williamboman/mason-lspconfig.nvim/issues/371#issuecomment-2018863753
            ["volar"] = function()
                require("lspconfig").volar.setup({
                    filetypes = { "vue", "javascript", "typescript" },
                    init_options = {
                        vue = {
                            hybridMode = false,
                        },
                        typescript = {
                            tsdk = vim.fn.getcwd() .. "node_modules/typescript/lib",
                        },
                    },
                })
            end
        },
    })

end
