return function()
  require("gitmoji").setup({
    filetypes = { "gitcommit", "octo", "neo-tree-popup" },
    completion = {
      append_space = true,
      complete_as = "text",
    },
  })
end
