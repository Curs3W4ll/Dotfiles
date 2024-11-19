local function getNamespacesByName(names)
  local neokit = require("neokit")
  local namespaces = {}

  for i, e in pairs(vim.diagnostic.get_namespaces()) do
    if neokit.table.contains(names, e.name) then
      namespaces = neokit.table.concat(namespaces, { i })
    end
  end
  return namespaces
end
local function areDiagnosticsNamespacesDisabled(namespaces)
  for _, namespace in ipairs(namespaces) do
    if not vim.diagnostic.is_disabled(0, namespace) then
      return false
    end
  end
  return true
end
local function disableDiagnosticNamespaces(namespaces)
  for _, namespace in ipairs(namespaces) do
    vim.diagnostic.disable(0, namespace)
    vim.diagnostic.reset(namespace, 0)
  end
end
local function enableDiagnosticNamespaces(namespaces)
  for _, namespace in ipairs(namespaces) do
    vim.diagnostic.enable(0, namespace)
  end
end
local function toggleGrammarChecks()
  local notify = require("notify")
  local linters = {
    "codespell",
    "proselint",
    "vale",
  }
  local lintersNamespaces = getNamespacesByName(linters)

  local grammarlyClient = require("lspconfig").util.get_active_client_by_name(0, "grammarly")
  if
    (grammarlyClient and grammarlyClient.is_stopped() == false)
    or not areDiagnosticsNamespacesDisabled(lintersNamespaces)
  then
    if grammarlyClient then
      grammarlyClient.stop()
    end
    disableDiagnosticNamespaces(lintersNamespaces)
    notify.notify("Grammar checkers have been turned off", "info")
  else
    enableDiagnosticNamespaces(lintersNamespaces)
    notify.notify("Grammar checkers have been turned on", "info")
  end
end
local function applyCodeAction()
  vim.lsp.buf.code_action({ apply = true })
end

return {
  setup = function(client, bufnbr)
    local wk = require("which-key")

    require("neokit.vim").unmap("*", "K")
    wk.add({
      buffer = bufnbr,
      { "<leader>n", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Go next diagnostic" },
      { "<leader>N", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Go previous diagnostic" },
      { "<leader><C-G>", toggleGrammarChecks, desc = "Toggle grammar-related checks" },
      { "<leader>l", group = "LSP" },
      { "<leader>ld", group = "Diagnostics" },
      { "<leader>ldc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Display cursor diagnostics" },
      { "<leader>ldl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Display line diagnostics" },
      { "<leader>ldb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Display buffer diagnostics" },
      { "<leader>ldw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "Display workspace diagnostics" },
      {
        "<leader>ll",
        function()
          vim.diagnostic.setqflist()
        end,
        desc = "Display diagnostics in quickfix",
      },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Display LSP infos for buffer" },
      { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart LSP servers" },
      { "<leader>ls", "<cmd>LspStart<cr>", desc = "Start LSP servers" },
      { "<leader>lS", "<cmd>LspStop<cr>", desc = "Stop LSP servers" },
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Search references for cursor symbol" },
    })

    if client.supports_method("textDocument/declaration") then
      wk.add({
        buffer = bufnbr,
        {
          "g<C-D>",
          function()
            vim.lsp.buf.declaration()
          end,
          desc = "Go to symbol declaration",
        },
      })
    end
    if client.supports_method("textDocument/definition") then
      wk.add({
        buffer = bufnbr,
        { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to symbol definition" },
        { "gD", "<cmd>Lspsaga peek_definition<cr>", desc = "Preview symbol definition" },
      })
    end
    if client.supports_method("textDocument/implementation") then
      wk.add({
        buffer = bufnbr,
        {
          "gi",
          function()
            vim.lsp.buf.implementation()
          end,
          desc = "Go to symbol implementation",
        },
      })
    end
    if client.supports_method("textDocument/references") then
      wk.add({
        buffer = bufnbr,
        {
          "gr",
          function()
            vim.lsp.buf.references()
          end,
          desc = "Go to symbol references",
        },
      })
    end
    if client.supports_method("textDocument/hover") then
      wk.add({
        buffer = bufnbr,
        { "K<Space>", "<cmd>Lspsaga hover_doc<cr>", desc = "Display symbol documentation" },
        { "KK", "<cmd>Lspsaga hover_doc ++keep<cr>", desc = "Open symbol documentation" },
      })
    end
    if client.supports_method("textDocument/codeAction") then
      wk.add({
        buffer = bufnbr,
        { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Display diagnostic code actions" },
        { "<leader>qf", applyCodeAction, desc = "Apply diagnostic quickfix" },
      })
    end
    if client.supports_method("textDocument/rename") then
      wk.add({
        buffer = bufnbr,
        { "<leader>rn", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename symbol" },
      })
    end
  end,
}
