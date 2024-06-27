local wk = require("which-key")

wk.register({
  ["<Ctrl-F>"] = {
    function()
      local ls = require("luasnip")
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end,
    "Jump backward",
  },
}, {
  mode = { "i", "s" },
  silent = true,
})
