local count = require("neokit.str").count
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local function rec_table_column()
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        i(1, "title"),
        t("|"),
        d(2, rec_table_column, {}),
      }),
    })
  )
end

return {
  s({
    trig = "[",
    name = "link",
    dscr = "Insert a link",
  }, {
    t("["),
    i(1, "description"),
    t("]("),
    i(2, "https://url"),
    c(3, {
      sn(nil, {
        t(" \""),
        i(1, "bubble"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(")"),
  }),
  s({
    trig = "![",
    name = "image",
    dscr = "Insert an image",
  }, {
    t("!["),
    i(1, "alttext"),
    t("]("),
    i(2, "https://url-or-path"),
    c(3, {
      sn(nil, {
        t(" \""),
        i(1, "bubble"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(")"),
  }),
  s({
    trig = "*",
    name = "bold",
    dscr = "Insert a bold text weight",
  }, {
    t("**"),
    i(1),
    t("**"),
  }),
  s({
    trig = "_",
    name = "italic",
    dscr = "Insert an italic text weight",
  }, {
    t("__"),
    i(1),
    t("__"),
  }),
  s({
    trig = "code",
    name = "code block",
    dscr = "Insert a code block",
  }, {
    t("```"),
    i(1, "language"),
    t({ "", "\t" }),
    i(2),
    t({ "", "```" }),
  }),
  s({
    trig = "tbl",
    name = "table",
    dscr = "Insert a table",
  }, {
    t("|"),
    d(1, rec_table_column),
    t({ "", "|" }),
    f(function(args)
      return args[1][1]:gsub("[^|]", "-")
    end, { 1 }),
    t({ "", "|" }),
    d(2, function(args)
      local tbl = {}

      for idx = 1, count(args[1][1], "|") do
        table.insert(tbl, i(idx, "content"))
        table.insert(tbl, t("|"))
      end

      return sn(nil, tbl)
    end, { 1 }),
  }),
}, {}
