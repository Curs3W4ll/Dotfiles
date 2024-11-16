return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    exclude = {
      filetypes = {
        "dashboard",
      },
    },
  },
}
