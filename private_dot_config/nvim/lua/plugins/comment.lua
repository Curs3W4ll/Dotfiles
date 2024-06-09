return function()
  require("nvim_comment").setup({
    hook = function()
      print("Updating")
      require("ts_context_commentstring").update_commentstring()
    end,
    -- Do not comment empty lines
    comment_empty = false,
    -- Do not create default mappings
    create_mappings = false,
  })
end
