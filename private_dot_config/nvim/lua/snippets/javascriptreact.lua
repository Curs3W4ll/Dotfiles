local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

ls.filetype_extend("javascriptreact", { "javascript" })

return {
  s({
    trig = "dcmpt",
    name = "define component [tests]",
    dscr = "Define a custom local Vue component",
  }, {
    t("const "),
    i(1, "Test"),
    t({ "Component = defineComponent(", "\t() => {", "\t\treturn () => {", "\t\t\treturn " }),
    i(2, "<div></div>"),
    t({ "", "\t\t}", "\t}", ");" }),
  }),
  s({
    trig = "mnt",
    priority = 1001,
    name = "mount [tests]",
    dscr = "Mount a component using cypress",
  }, {
    t("cy.mount("),
    c(1, {
      sn(nil, {
        i(1, "Component"),
        c(2, {
          sn(nil, {
            t({ ", {", "\tprops: {", "\t\t" }),
            i(1, "prop: true,"),
            t({ "", "\t}," }),
          }),
          i(nil, ""),
        }),
        c(3, {
          sn(nil, {
            t({ ", {", "\tslots: {", "\t\t" }),
            i(1, "default: \"The slot value\","),
            t({ "", "\t}," }),
          }),
          i(nil, ""),
        }),
      }),
      sn(nil, {
        t({ "() =>", "\t<div></div>" }),
      }),
    }),
    t(");"),
  }),
}, {}
