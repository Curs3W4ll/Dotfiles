return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-context",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    auto_install = true,
    indent = {
      enable = true,
    },
  },
}
