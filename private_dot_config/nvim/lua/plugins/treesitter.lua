return function()
  require("nvim-treesitter.configs").setup({
    auto_install = true,
    indent = {
      enable = true,
    },
  })
end
