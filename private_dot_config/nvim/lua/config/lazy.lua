-- Setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "folke/lazy.nvim",
      version = "*",
    },
    { import = "plugins" },
  },
  install = {
    -- Setup colorscheme before setting up plugins (set colorscheme for lazy popup at startup)
    colorscheme = { "tokyonight" },
  },
  -- Updates checker
  checker = {
    -- Enable the update checker
    enabled = true,
    -- Disable notifications in console when update are availables
    notify = false,
    -- Check for updates every 24 hours
    frequency = 86400,
  },
  ui = {
    -- Use rounded border for Lazy UI window
    border = "rounded",
  },
})
