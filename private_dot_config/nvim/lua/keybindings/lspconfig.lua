local wk = require("which-key")

wk.register({
    -- ================================
    -- ========== Navigation ==========
    -- ================================
    n = { vim.diagnostic.goto_next, "Go to the next diagnostic" },
    N = { vim.diagnostic.goto_prev, "Go to the previous diagnostic" },
    l = {
        name = "LSP",
        {
            -- ================================
            -- ============ Display ===========
            -- ================================
            d = { vim.diagnostic.open_float, "Display diagnostics of a line" },
            l = { vim.diagnostic.setqflist, "Display diagnostics list in quickfix" },
            -- ================================
            -- ============   Misc  ===========
            -- ================================
            i = { ":LspInfo<CR>", "Display LSP infos of buffer" },
            r = { ":LspRestart<CR>", "Restart LSP server(s)" },
            s = { ":LspStop<CR>", "Stop LSP server(s)" },
        },
    },
}, {
    mode = "n",
    prefix = "<leader>",
})

local function applyCodeAction()
    vim.lsp.buf.code_action({ apply = true })
end

return function(client, buf_nbr)
    local opts = {
        mode = "n",
        buffer = buf_nbr,
    }

    if client.supports_method("textDocument/declaration") then
        wk.register({
            gD = { vim.lsp.buf.declaration, "Go to symbol declaration" },
        }, opts)
    end
    if client.supports_method("textDocument/definition") then
        wk.register({
            gd = { vim.lsp.buf.definition, "Go to symbol definition" },
        }, opts)
    end
    if client.supports_method("textDocument/implementation") then
        wk.register({
            gi = { vim.lsp.buf.implementation, "Go to symbol implementation" },
        }, opts)
    end
    if client.supports_method("textDocument/references") then
        wk.register({
            gr = { vim.lsp.buf.references, "Display symbol references" },
        }, opts)
    end
    if client.supports_method("textDocument/hover") then
        wk.register({
            K = { vim.lsp.buf.hover, "Display symbol documentation" },
        }, opts)
    end
    if client.supports_method("textDocument/codeAction") then
        wk.register({
            ["<leader>ca"] = { vim.lsp.buf.code_action, "Display code actions for diagnostic" },
        }, opts)
        wk.register({
            ["<leader>qf"] = { applyCodeAction, "Apply quickfix for diagnostic" },
        }, opts)
    end
    if client.supports_method("textDocument/rename") then
        wk.register({
            ["<leader>rn"] = { vim.lsp.buf.rename, "Rename symbol" },
        }, opts)
    end

end
