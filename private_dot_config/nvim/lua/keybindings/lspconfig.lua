local wk = require("which-key")
local notify = require("notify")
local utils = require("utils")

local function getNamespacesByName(names)
    local namespaces = {}
    for i,e in pairs(vim.diagnostic.get_namespaces()) do
        if utils.tbl_has_value(names, e.name) then
            namespaces = utils.tbl_concat(namespaces, { i })
        end
    end
    return namespaces
end
local function areDiagnosticsNamespacesDisabled(namespaces)
    for _,namespace in ipairs(namespaces) do
        if not vim.diagnostic.is_disabled(0, namespace) then
            return false
        end
    end
    return true
end
local function disableDiagnosticNamespaces(namespaces)
    for _,namespace in ipairs(namespaces) do
        vim.diagnostic.disable(0, namespace)
        vim.diagnostic.reset(namespace, 0)
    end
end
local function enableDiagnosticNamespaces(namespaces)
    for _,namespace in ipairs(namespaces) do
        vim.diagnostic.enable(0, namespace)
    end
end
local function toggleGrammarChecks()
    local linters = {
        "codespell",
        "proselint",
        "vale",
    }
    local lintersNamespaces = getNamespacesByName(linters)

    local grammarlyClient = require("lspconfig").util.get_active_client_by_name(0, "grammarly")
    if (grammarlyClient and grammarlyClient.is_stopped() == false) or not areDiagnosticsNamespacesDisabled(lintersNamespaces) then
        if grammarlyClient then
            grammarlyClient.stop()
        end
        disableDiagnosticNamespaces(lintersNamespaces)
        notify.notify("Grammar checkers have been turned off", "info")
    else
        local availableLSPForCurrentFt = utils.toList(require("lspconfig").util.get_config_by_ft(vim.bo.filetype), "name")
        if utils.tbl_has_value(availableLSPForCurrentFt, "grammarly") then
            vim.cmd("LspStart grammarly")
        else
            notify.notify("Cannot turn on grammarly LSP as it does not support the " .. vim.bo.filetype .. " filetype", "warn")
        end
        enableDiagnosticNamespaces(lintersNamespaces)
        notify.notify("Grammar checkers have been turned on", "info")
    end
end

wk.register({
    -- ================================
    -- ========== Navigation ==========
    -- ================================
    n = { "<Cmd>Lspsaga diagnostic_jump_next<CR>", "Go to the next diagnostic" },
    N = { "<Cmd>Lspsaga diagnostic_jump_prev<CR>", "Go to the previous diagnostic" },
    l = {
        name = "LSP",
        {
            -- ================================
            -- ============ Display ===========
            -- ================================
            d = {
                name = "Diagnostics",
                c = { "<Cmd>Lspsaga show_cursor_diagnostics<CR>", "Display diagnostics of the cursor" },
                l = { "<Cmd>Lspsaga show_line_diagnostics<CR>", "Display diagnostics of the line" },
                b = { "<Cmd>Lspsaga show_buf_diagnostics<CR>", "Display diagnostics of the buffer" },
                w = { "<Cmd>Lspsaga show_workspace_diagnostics<CR>", "Display diagnostics of the workspace" },
            },
            l = { vim.diagnostic.setqflist, "Display diagnostics list in quickfix" },
            -- ================================
            -- ============   Misc  ===========
            -- ================================
            i = { "<Cmd>LspInfo<CR>", "Display LSP infos of buffer" },
            r = { "<Cmd>LspRestart<CR>", "Restart LSP server(s)" },
            s = { "<Cmd>LspStart<CR>", "Start LSP server(s)" },
            S = { "<Cmd>LspStop<CR>", "Stop LSP server(s)" },
            f = { "<Cmd>Lspsaga finder<CR>", "Search references of the symbol under cursor" },
        },
    },
    -- ================================
    -- ===           Misc           ===
    -- ================================
    ["<C-g>"] = { toggleGrammarChecks, "Toggle grammar-related checks (LSP & Linter)" },
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
            gd = { "<Cmd>Lspsaga goto_definition<CR>", "Go to symbol definition" },
            gD = { "<Cmd>Lspsaga peek_definition<CR>", "Preview symbol definition" },
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
            ["K<Space>"] = { "<Cmd>Lspsaga hover_doc<CR>", "Display symbol documentation" },
            KK = { "<Cmd>Lspsaga hover_doc ++keep<CR>", "Open symbol documentation" },
        }, opts)
    end
    if client.supports_method("textDocument/codeAction") then
        wk.register({
            ["<leader>ca"] = { "<Cmd>Lspsaga code_action<CR>", "Display code actions for diagnostic" },
        }, opts)
        wk.register({
            ["<leader>qf"] = { applyCodeAction, "Apply quickfix for diagnostic" },
        }, opts)
    end
    if client.supports_method("textDocument/rename") then
        wk.register({
            ["<leader>rn"] = { "<Cmd>Lspsaga rename ++project<CR>", "Rename symbol" },
        }, opts)
    end

end
