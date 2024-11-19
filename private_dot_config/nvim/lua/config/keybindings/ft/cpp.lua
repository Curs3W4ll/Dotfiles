return {
  setup = function(bufnbr)
    if package.loaded["which-key"] then
      local wk = require("which-key")

      wk.add({
        buffer = bufnbr,
        mode = { "n", "v", "s" },
        { "<leader>co", "<cmd>CPPMan<cr>", desc = "Open CPPMan search (cppreference.com)" },
        {
          "<leader>c<Enter>",
          function()
            require("cppman").open_cppman_for(vim.fn.expand("<cword>"))
          end,
          desc = "Search CPPMan for word under cursor",
        },
      })
    end
  end,
}
