return function()
  require("nvim-autopairs").setup({
    check_ts = true,
    fast_wrap = {
      map = "<C-e>",
      chars = { "{", "[", "(", "\"", "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = "$",
      before_key = "h",
      after_key = "l",
      cursor_pos_before = false,
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      manual_position = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  })
end
