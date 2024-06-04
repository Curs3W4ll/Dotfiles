local tmpGroup = vim.api.nvim_create_augroup("tmp", { clear = true })

-- Temporary fix tabsize break on lua and cpp/c files
vim.api.nvim_create_autocmd(
  { "FileType" },
  { pattern = "lua,cpp,c", command = "setlocal tabstop=4 shiftwidth=4", group = tmpGroup }
)

-- LSP fixing
local function isLSPClientActive(name)
  return #vim.lsp.get_clients({ name = name }) > 0
end
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    -- NOTE: Disable tsserver when volar is running (or will run two times the same lsp)
    if client.name == "volar" then
      if isLSPClientActive("tsserver") then
        require("neokit.array").forEach(vim.lsp.get_clients({ name = "tsserver" }), function(elem)
          elem.stop()
        end)
      end
    elseif client.name == "tsserver" then
      if isLSPClientActive("volar") then
        client.stop()
      end
    end
  end,
  group = tmpGroup,
})
