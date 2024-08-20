local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s({
    trig = "xml",
    name = "xml tag",
    dscr = "Insert XML version tag",
  }, {
    t("<?xml version=\""),
    i(1, "1.0"),
    t("\", encoding=\""),
    i(2, "UTF-8"),
    t("\"?>"),
  }),
  s({
    trig = "t",
    name = "tag",
    dscr = "Insert a tag",
  }, {
    t("<"),
    i(1),
    t({ ">", "\t" }),
    i(2),
    t({ "", "</" }),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t(">"),
  }),
}, {}
