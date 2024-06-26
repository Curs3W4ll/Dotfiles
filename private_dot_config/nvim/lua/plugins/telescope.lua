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
      file_ignore_patterns = {
        ".git/",
      },
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("gitmoji")
  require("telescope").load_extension("yank_history")
end
