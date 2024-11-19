local groups = require("config.commands")

-- cpp
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "cpp",
  callback = function(ev)
    require("config.keybindings.ft.cpp").setup(ev.buf)
  end,
  group = groups.filetypeDetectGroup,
})
-- cppman
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "cppman",
  callback = function(ev)
    require("config.keybindings.ft.cppman").setup(ev.buf)
  end,
  group = groups.filetypeDetectGroup,
})
-- markdown
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function(ev)
    require("config.keybindings.ft.markdown").setup(ev.buf)
  end,
  group = groups.filetypeDetectGroup,
})
