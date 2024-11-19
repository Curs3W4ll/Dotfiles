return {
  "terrortylor/nvim-comment",
  main = "nvim_comment",
  event = "VeryLazy",
  opts = {
    hook = function()
      if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
        require("ts_context_commentstring").update_commentstring()
      end
    end,
    comment_empty = false,
    create_mappings = false,
  },
}
