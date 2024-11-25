return {
  "petertriho/nvim-scrollbar",
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  opts = function()
    local colors = require("tokyonight.colors").setup()

    return {
      -- Hide scrollbar if all lines are visible
      hide_if_all_visible = true,
      set_highlights = true,
      handle = {
        -- Use tokyonight color
        color = colors.bg_highlight,
      },
      marks = {
        Search = {
          -- Use tokyonight color
          color = colors.orange,
        },
        Error = {
          -- Use tokyonight color
          color = colors.error,
        },
        Warn = {
          -- Use tokyonight color
          color = colors.warning,
        },
        Info = {
          -- Use tokyonight color
          color = colors.info,
        },
        Hint = {
          -- Use tokyonight color
          color = colors.hint,
        },
        Misc = {
          -- Use tokyonight color
          color = colors.purple,
        },
      },
      handlers = {
        -- Disable cursor position
        cursor = false,
        -- Enable diagnostics
        diagnostic = true,
        -- Disable git signs
        gitsigns = false,
        -- Enable search
        search = true,
        -- Disable ALE
        ale = false,
      },
    }
  end,
  config = function(_, opts)
    require("scrollbar").setup(opts)
    require("scrollbar.handlers.search").setup({})
    require("scrollbar.handlers.gitsigns").setup({})
  end,
}
