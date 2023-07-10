local tmpGroup = vim.api.nvim_create_augroup("tmp", { clear = true })

-- Temporary fix tabsize break on lua and cpp/c files
vim.api.nvim_create_autocmd(
  { "FileType" },
  { pattern = "lua,cpp,c", command = "setlocal tabstop=4 shiftwidth=4", group = tmpGroup }
)
