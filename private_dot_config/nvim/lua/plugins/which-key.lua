return function()
  require("which-key").setup({
    plugins = {
      spelling = {
        -- Enabling spelling suggestions
        enabled = true,
      },
    },
    popup_mappings = {
      -- Binding to scroll down inside the popup
      scroll_down = "<C-j>",
      -- Binding to scroll up inside the popup
      scroll_up = "<C-k>",
    },
    window = {
      -- Look of window borders
      border = "double",
      -- Position of the window
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 0, 2, 0, 2 },
      -- Transparence of the window, 100 will make it fully transparent
      winblend = 30,
    },
    layout = {
      -- Size of the displayed keys layout
      height = { min = 5, max = 20 },
      -- Spacing between columns
      spacing = 5,
    },
    -- List of triggers, where WhichKey should not wait for timeoutlen and show immediately
    triggers_nowait = {
      -- Marks
      "`",
      "'",
      "g`",
      "g'",
      -- Registers
      "\"",
      "<c-r>",
      -- Spelling
      "z=",
    },
    -- Disable the WhichKey popup for certain buf types and file types.
    -- The plugin is disabled by default for Telescope
    disable = {
      buftypes = {},
      filetypes = {},
    },
  })
end
