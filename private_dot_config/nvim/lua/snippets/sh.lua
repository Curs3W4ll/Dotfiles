local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local function rec_elif()
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        t({ "", "elif [[ " }),
        i(1, "false"),
        t({ " ]]; then", "\t" }),
        i(2),
        d(3, rec_elif, {}),
      }),
    })
  )
end

return {
  s({
    trig = "if",
    name = "if condition",
    dscr = "Insert an if condition",
  }, {
    t("if [[ "),
    i(1, "true"),
    t({ " ]]; then", "\t" }),
    i(2),
    d(3, rec_elif, {}),
    c(4, {
      sn(nil, {
        t({ "", "else", "\t" }),
        i(1),
        t({ "", "fi" }),
      }),
      i(nil, ""),
    }),
  }),
  s({
    trig = "while",
    name = "while statement",
    dscr = "Insert a while statement",
  }, {
    t("while [[ "),
    i(1, "true"),
    t({ " ]]; do", "\t" }),
    i(2),
    t({ "", "done" }),
  }),
}, {
  s({
    trig = "#!",
    name = "shebang",
    dscr = "Insert a shebang comment",
  }, {
    t("#!/usr/bin/env "),
    c(1, {
      i(1, "bash"),
      i(2, "sh"),
    }),
  }),
}
