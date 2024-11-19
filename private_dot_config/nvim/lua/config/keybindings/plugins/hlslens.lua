return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      noremap = true,
      silent = true,
      {
        "n",
        "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>",
        desc = "Go to next search result",
      },
      {
        "N",
        "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>",
        desc = "Go to previous search result",
      },
      { "*", "*<cmd>lua require('hlslens').start()<cr>", desc = "Search current word", noremap = true, silent = true },
      { "#", "*<cmd>lua require('hlslens').start()<cr>", desc = "Search current word", noremap = true, silent = true },
      {
        "g*",
        "g*<cmd>lua require('hlslens').start()<cr>",
        desc = "Search containing current word",
      },
      {
        "g#",
        "g#<cmd>lua require('hlslens').start()<cr>",
        desc = "Search containing current word",
      },
    })
  end,
}
