local fts = { "gitcommit", "neo-tree-popup", "octo" }

return {
  "Dynge/gitmoji.nvim",
  ft = fts,
  lazy = true,
  opts = {
    filetypes = fts,
    completion = {
      append_space = true,
      complete_as = "text",
    },
  },
}
