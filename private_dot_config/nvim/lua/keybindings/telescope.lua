local wk = require("which-key")

wk.register({
  f = {
    name = "Telescope",
    f = {
      function()
        require("telescope.builtin").find_files()
      end,
      "Find files",
    },
    t = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "Find text in files",
    },
    s = {
      function()
        require("telescope.builtin").grep_string()
      end,
      "Find the string under the cursor",
    },
    c = {
      function()
        require("telescope.builtin").commands()
      end,
      "Search through available comands",
    },
    w = {
      function()
        require("telescope.builtin").spell_suggest()
      end,
      "Search through spell suggestion for word under cursor",
    },
    k = {
      function()
        require("telescope.builtin").keymaps()
      end,
      "Search through available keymaps",
    },
    d = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Search through LSP diagnostics",
    },
    g = {
      name = "Git actions",
      c = {
        function()
          require("telescope.builtin").git_commits()
        end,
        "Search through Git commits",
      },
      b = {
        function()
          require("telescope.builtin").git_branches()
        end,
        "Search through Git branches",
      },
      s = {
        function()
          require("telescope.builtin").git_stash()
        end,
        "Search through current Git stashed files",
      },
      g = {
        function()
          require("telescope").extensions.gitmoji.gitmoji()
        end,
        "Search through gitmojies",
      },
    },
  },
}, {
  mode = "n",
  prefix = "<leader>",
})
