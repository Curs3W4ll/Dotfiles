return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "neo-tree-popup",
        "checkhealth",
        "qf",
      },
    })
  end,
}
