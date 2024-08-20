local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

return {
  s({
    trig = "tbl",
    name = "create table",
    dscr = "Create a new table",
  }, {
    t("create table "),
    i(1, "tblname"),
    t({ " (", "\t" }),
    i(2),
    t({ "", ");" }),
  }),
  s({
    trig = "col",
    name = "create column",
    dscr = "Create a new column",
  }, {
    i(1, "name"),
    t("\t"),
    i(2, "type"),
    c(3, {
      sn(nil, {
        t("\tdefault "),
        i(1, "defvalue"),
      }),
      i(nil, ""),
    }),
    t("\t"),
    c(4, {
      i(1, "not null"),
      i(1, "null"),
    }),
  }),
  s({
    trig = "idx",
    name = "create index",
    dscr = "Create a new index",
  }, {
    i(1, "create "),
    c(2, {
      i(1, "unique "),
      i(nil, ""),
    }),
    t("index "),
    i(3, "name"),
    t(" on "),
    i(4, "table"),
    t("("),
    i(5, "columns"),
    t(");"),
  }),
}, {}
