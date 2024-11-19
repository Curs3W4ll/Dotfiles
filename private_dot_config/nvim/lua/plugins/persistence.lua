return {
  "folke/persistence.nvim",
  event = "VeryLazy",
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
  },
}
