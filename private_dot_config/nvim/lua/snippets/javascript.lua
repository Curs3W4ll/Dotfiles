local concat = require("neokit.array").concat
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local function rec_else_if()
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        t(" else if ("),
        i(1, "false"),
        t({ ") {", "\t" }),
        i(2),
        t({ "", "}" }),
        d(3, rec_else_if, {}),
      }),
    })
  )
end

local function rec_switch_case()
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        t({ "", "\tcase " }),
        i(1, "value"),
        t({ ":", "\t\t" }),
        i(2),
        t({ "", "\t\tbreak;" }),
        d(3, rec_switch_case, {}),
      }),
    })
  )
end

local function rec_function_arg(args)
  local separators = {}
  if args and args[1] and args[1][1] ~= "" then
    table.insert(separators, t(", "))
  end

  return sn(
    nil,
    c(1, {
      i(nil, ""),
      sn(
        nil,
        concat(separators, {
          i(1, "var"),
          d(2, rec_function_arg, { 1 }),
        })
      ),
    })
  )
end

local function rec_class_attr()
  return sn(
    nil,
    c(1, {
      i(nil, ""),
      sn(nil, {
        t("\t"),
        c(1, {
          i(1, "readonly "),
          i(nil, ""),
        }),
        i(2, "attribute"),
        t({ ";", "" }),
        d(3, rec_class_attr, {}),
      }),
    })
  )
end

return {
  s({
    trig = "desc",
    name = "describe [tests]",
    dscr = "Insert a describe test function",
  }, {
    t("describe(\""),
    i(1, "the thing"),
    t({ "\", () => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "ctx",
    name = "context [tests]",
    dscr = "Insert a context test function",
  }, {
    t("context(\""),
    i(1, "the case"),
    t({ "\", () => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "it",
    name = "it [tests]",
    dscr = "Insert an it test function",
  }, {
    t("it(\""),
    i(1, "should do ..."),
    t({ "\", () => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "bef",
    name = "beforeEach [tests]",
    dscr = "Insert a beforeEach test function",
  }, {
    t({ "beforeEach(() => {", "\t" }),
    i(1),
    t({ "", "});" }),
  }),
  s({
    trig = "aft",
    name = "afterEach [tests]",
    dscr = "Insert a afterEach test function",
  }, {
    t({ "beforeEach(() => {", "\t" }),
    i(1),
    t({ "", "});" }),
  }),
  s({
    trig = "gbd",
    name = "getByData [tests]",
    dscr = "Insert a cypress getByData command",
  }, {
    t("cy.getByData(\""),
    i(1, "main-content"),
    t("\")."),
    i(2),
  }),
  s({
    trig = "visit",
    name = "visit [tests]",
    dscr = "Insert a cypress visit command",
  }, {
    t("cy.visit(\""),
    i(1, "/page"),
    t("\");"),
  }),
  s({
    trig = "vp",
    name = "viewport [tests]",
    dscr = "Insert a cypress viewport command",
  }, {
    t("cy.viewport("),
    i(1, "1920"),
    t(","),
    i(2, "1080"),
    t(");"),
  }),
  s({
    trig = "url",
    name = "url (location) [tests]",
    dscr = "Insert a cypress location path (URL) command",
  }, {
    t("cy.location(\"pathname\").should(\"eq\", \""),
    i(1, "/"),
    t("\");"),
  }),
  s({
    trig = "cont",
    name = "contains [tests]",
    dscr = "Insert a cypress contains command",
  }, {
    t("cy.contains(\""),
    i(1, "something"),
    t("\")"),
    i(2, ";"),
  }),
  s({
    trig = "get",
    name = "get [tests]",
    dscr = "Insert a cypress get command",
  }, {
    t("cy.get(\""),
    i(1, "body"),
    t("\")."),
    i(2, ";"),
  }),
  s({
    trig = "ex",
    name = "exist [tests]",
    dscr = "Insert a cypress should exist command",
  }, {
    t("should(\""),
    c(1, {
      i(1, "not."),
      i(nil, ""),
    }),
    t("exist\");"),
  }),
  s({
    trig = "vis",
    name = "visible [tests]",
    dscr = "Insert a cypress should be visible command",
  }, {
    t("should(\""),
    c(1, {
      i(1, "not."),
      i(nil, ""),
    }),
    t("be.visible\");"),
  }),
  s({
    trig = "foc",
    name = "focused [tests]",
    dscr = "Insert a cypress should have focus command",
  }, {
    t("should(\""),
    c(1, {
      i(1, "not."),
      i(nil, ""),
    }),
    t("have.focus\");"),
  }),
  s({
    trig = "mnt",
    name = "mount [tests]",
    dscr = "Mount a component using cypress",
  }, {
    t("cy.mount("),
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
    t(");"),
  }),
  s({
    trig = "if",
    name = "if condition",
    dscr = "Insert an if condition",
  }, {
    t("if ("),
    i(1, "true"),
    t({ ") {", "\t" }),
    i(2),
    t({ "", "}" }),
    d(3, rec_else_if, {}),
    c(4, {
      sn(nil, {
        t({ " else {", "\t" }),
        i(1),
        t({ "", "}" }),
      }),
      i(nil, ""),
    }),
  }),
  s({
    trig = "switch",
    name = "switch case",
    dscr = "Insert a switch statement",
  }, {
    t("switch ("),
    i(1, "variable"),
    t(") {"),
    d(2, rec_switch_case, {}),
    c(3, {
      sn(nil, { t({ "", "\tdefault:", "\t\t" }), i(1) }),
      i(nil, ""),
    }),
    t({ "", "}" }),
  }),
  s({
    trig = "trn",
    name = "ternary condition",
    dscr = "Insert a ternary condition",
  }, {
    t("("),
    i(1, "condition"),
    t(" ? "),
    i(2, "yes"),
    t(" : "),
    i(3, "no"),
    t(")"),
  }),
  s({
    trig = "while",
    name = "while statement",
    dscr = "Insert a while statement",
  }, {
    t("while ("),
    i(1, "true"),
    t({ ") {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),
  s({
    trig = "for",
    name = "for statement",
    dscr = "Insert a for statement",
  }, {
    t("for ("),
    i(1, "short i = 0"),
    t("; "),
    i(2, "i < count"),
    t("; "),
    i(3, "i++"),
    t({ ") {", "\t" }),
    i(4),
    t({ "", "}" }),
  }),
  s({
    trig = "ret",
    name = "return statement",
    dscr = "Insert a return statement",
  }, {
    t("return "),
    i(1, "0"),
    t(";"),
  }),
  s({
    trig = "fun",
    name = "function declaration",
    dscr = "Declare a new function",
  }, {
    c(1, {
      i(1, "export "),
      i(nil, ""),
    }),
    t("const "),
    i(2, "fname"),
    t(" = ("),
    d(3, rec_function_arg, {}),
    t({ ") => {", "\t" }),
    i(4),
    t({ "", "};" }),
  }),
  s({
    trig = "enum",
    name = "enum declaration",
    dscr = "Declare an enum",
  }, {
    t("enum"),
    i(1, "name"),
    t({ "", "\t" }),
    i(2),
    t({ "", "}" }),
  }),
  s({
    trig = "pr",
    name = "print",
    dscr = "Insert a console log",
  }, {
    t("console.log("),
    i(1),
    t(");"),
  }),
  s({
    trig = "class",
    name = "class declaration",
    dscr = "Declare a new class",
  }, {
    c(1, {
      i(1, "export "),
      i(nil, ""),
    }),
    t("class "),
    i(2, "C"),
    t({ " {", "" }),
    d(3, rec_class_attr, {}),
    d(4, function(args)
      if args and args[1] and args[1][1] ~= "" then
        return sn(nil, {
          t({ "", "" }),
        })
      end
      return sn(nil, { t("") })
    end, { 3 }),
    c(5, {
      sn(nil, {
        t("\tconstructor("),
        i(1),
        t({ ") {", "\t\t" }),
        i(2),
        t({ "", "\t}" }),
      }),
      i(nil, ""),
    }),
    i(6),
    t({ "", "}" }),
  }),
}, {}
