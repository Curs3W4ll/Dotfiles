return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      -- Airline theme
      theme = "tokyonight",
      -- Keep only one line at the bottom for all the windows instead of one statusline for each window
      globalstatus = true,
    },
    sections = {
      -- Display vim mode (normal, insert, command, visual) in first section
      lualine_a = { "mode" },
      -- Display git branch, status and lsp diagnostics in second section
      lualine_b = { "branch", "diff", "diagnostics" },
      -- Display file name and size in third section
      lualine_c = {
        {
          "filename",
          -- Display when file is new newfile_status = false,
          -- Relative path
          path = 1,
        },
        "filesize",
      },
      -- Display file encoding, format (linux, mac, windows) and type (c++, c, txt...) in fourth section
      lualine_x = { "encoding", "fileformat", "filetype" },
      -- Display lines progress, x and y locations, search count and selection count in fifth section
      lualine_y = { "progress", "location", "searchcount", "selectioncount" },
      -- Display if their is lazy updates and datetime in last section
      lualine_z = {
        {
          "datetime",
          -- Day name day number month name, time (hours:minutes:seconds) updating in real time
          style = "%A %d %B, %X",
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#d44300" },
        },
      },
    },
  },
}
