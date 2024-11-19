return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>f", group = "Telescope" },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
        desc = "Find files",
      },
      {
        "<leader>ft",
        function()
          require("telescope.builtin").live_grep({ hidden = true })
        end,
        desc = "Find text in files",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").grep_string({ hidden = true })
        end,
        desc = "Find string under cursor",
      },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Search through available commands" },
      {
        "<leader>fw",
        "<cmd>Telescope spell_suggest<cr>",
        desc = "Search through spell suggestions for word under cursor",
      },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search through available keymaps" },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").diagnostics({ hidden = true })
        end,
        desc = "Search through LSP diagnostics",
      },
      { "<leader>fy", "<cmd>Telescope yank_history<cr>", desc = "Search through yank history" },
      { "<leader>fg", group = "Git actions" },
      { "<leader>fgc", "<cmd>Telescope git_bcommits<cr>", desc = "Search through buffer Git commits" },
      { "<leader>fgC", "<cmd>Telescope git_commits<cr>", desc = "Search through Git commits" },
      { "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "Search through Git branches" },
      {
        "<leader>fgs",
        function()
          require("telescope.builtin").git_stash({ hidden = true })
        end,
        desc = "Search through Git stashed files",
      },
      { "<leader>fgg", "<cmd>Telescope gitmoji<cr>", desc = "Search through gitmojies" },
    })
  end,
}
