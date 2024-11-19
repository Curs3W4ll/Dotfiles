return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "RishabhRD/popfix",
    "RishabhRD/nvim-lsputils",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/lazydev.nvim",
    "nvimdev/lspsaga.nvim",
    "Curs3W4ll/NeoKit",
    "rcarriga/nvim-notify",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lsp_servers = require("config.mason-tools").lsp
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local signs = require("config.signs")

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- ================================
    -- ========Diagnostics look========
    -- ================================
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = true,
      virtual_text = {
        prefix = "",
      },
    })
    vim.fn.sign_define("DiagnosticSignError", { text = signs.diagnostics.error, texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = signs.diagnostics.warning, texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = signs.diagnostics.info, texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = signs.diagnostics.hint, texthl = "DiagnosticSignHint" })

    -- ================================
    -- ===========LSP setup============
    -- ================================
    for _, server in ipairs(lsp_servers) do
      local lsp_name = server.name
      if server.lsp_name ~= nil then
        lsp_name = server.lsp_name
      end
      local settings = {
        on_attach = function(client, bufnbr)
          require("config.keybindings.plugins.lspconfig").setup(client, bufnbr)
        end,
        capabilities = capabilities,
      }
      if server.additional_settings ~= nil then
        settings = vim.tbl_extend("force", settings, server.additional_settings)
      end
      lspconfig[lsp_name].setup(settings)
    end
  end,
}
