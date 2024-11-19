return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Trouble",
  opts = {
    -- Close the window automatically when list is empty
    auto_close = true,
    -- Use signs defined by the lsp
    use_diagnostic_signs = true,
  },
}
