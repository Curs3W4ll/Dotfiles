return {
  "williamboman/mason.nvim",
  lazy = true,
  opts = {
    ui = {
      border = "rounded",
    },
    log_level = vim.log.levels.DEBUG,
  },
  config = function(_, opts)
    require("mason").setup(opts)

    require("mason-registry").update()
  end,
}
