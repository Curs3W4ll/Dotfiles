return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    {
      "olacin/telescope-gitmoji.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    "gbprod/yanky.nvim",
  },
  opts = function()
    local actions = require("telescope.actions")

    return {
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
      extensions = {
        gitmoji = {
          action = function(entry)
            vim.ui.input({ prompt = "Enter commit message: " .. entry.value.value .. " " }, function(msg)
              if not msg then
                return
              end

              local git_tool = ":!git"
              if vim.g.loaded_fugitive then
                git_tool = ":G"
              end
              vim.cmd(string.format("%s commit -m '%s %s'", git_tool, entry.value.text, msg))
            end)
          end,
        },
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("gitmoji")
    require("telescope").load_extension("yank_history")
  end,
}
