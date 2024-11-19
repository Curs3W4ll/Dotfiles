return {
  "nvimdev/lspsaga.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    code_action = {
      show_server_name = true,
      extend_gitsigns = true,
      keys = {
        quit = { "q", "<Esc>", "<C-c>" },
      },
    },
    definition = {
      keys = {
        split = "<C-c>s",
      },
    },
    diagnostic = {
      show_code_action = true,
      jump_num_shortcut = true,
      extend_relatedInformation = true,
      keys = {
        quit = { "q", "<Esc>", "<C-c>" },
      },
    },
    finder = {
      default = "def+imp+ref",
      methods = {
        tyd = "textDocument/typeDefinition",
      },
      keys = {
        quit = { "q", "<Esc>", "<C-c>" },
        shuttle = "<C-c><Space>",
        split = "s",
      },
    },
    hover = {
      open_link = "<C-c>o",
      open_cmd = "!brave-browser",
    },
    lightbulb = {
      enable = false,
    },
    rename = {
      auto_save = true,
      keys = {
        quit = { "<C-c>", "<Esc>" },
        select = "<Space>",
      },
    },
    scroll_preview = {
      scroll_down = "<C-c>n",
      scroll_up = "<C-c>N",
    },
  },
}
