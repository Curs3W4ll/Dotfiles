return function()
  vim.o.winwidth = 15
  vim.o.winminwidth = 15
  vim.o.equalalways = false
  require("windows").setup()
end
