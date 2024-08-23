local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({
    trig = "!",
    name = "important mark",
    dscr = "Insert the !important markup",
  }, {
    t("!important"),
  }),
}, {
  s({
    trig = ".{",
    name = "class css stylesheet",
    dscr = "Insert a css stylesheet for a class",
  }, {
    t("."),
    i(1, "id"),
    t({ " {", "\t" }),
    i(2),
    t({ ";", "" }),
  }),
  s({
    trig = "#{",
    name = "id css stylesheet",
    dscr = "Insert a css stylesheet for an id",
  }, {
    t("#"),
    i(1, "id"),
    t({ " {", "\t" }),
    i(2),
    t({ ";", "" }),
  }),
}
