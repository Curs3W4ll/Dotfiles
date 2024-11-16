return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  event = { "WinClosed", "WinEnter", "WinLeave", "WinNew", "WinResized" },
  init = function()
    vim.o.winwidth = 15
    vim.o.winminwidth = 15
    vim.o.equalalways = false
  end,
  opts = {},
}
