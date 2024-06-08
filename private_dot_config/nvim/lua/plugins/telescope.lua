return function()
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
        },
        n = {
          ["<C-c>"] = actions.close,
        },
      },
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("gitmoji")
end
