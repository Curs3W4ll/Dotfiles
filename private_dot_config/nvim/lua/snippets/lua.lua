local concat = require("neokit.array").concat
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local function rec_else_if()
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        t({ "", "elseif " }),
        i(1, "false"),
        t({ "then", "\t" }),
        i(2),
        d(3, rec_else_if, {}),
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

return {
  s({
    trig = "local",
    name = "local value",
    dscr = "Define a local value",
  }, {
    t("local "),
    i(1, "x"),
    t(" = "),
    i(2, "1"),
  }),
  s({
    trig = "if",
    name = "if condition",
    dscr = "Insert an if condition",
  }, {
    t("if "),
    i(1, "true"),
    t({ " then", "\t" }),
    i(2),
    d(3, rec_else_if, {}),
    c(4, {
      sn(nil, {
        t({ "", "else", "\t" }),
        i(1),
      }),
      i(nil, ""),
    }),
    t({ "", "end" }),
  }),
  s({
    trig = "trn",
    name = "ternary condition",
    dscr = "Insert a ternary condition",
  }, {
    t("("),
    i(1, "condition"),
    t(" and "),
    i(2, "yes"),
    t(" or "),
    i(3, "no"),
    t(")"),
  }),
  s({
    trig = "while",
    name = "while statement",
    dscr = "Insert a while statement",
  }, {
    t("while "),
    i(1, "true"),
    t({ " do", "\t" }),
    i(2),
    t({ "", "end" }),
  }),
  s({
    trig = "for",
    name = "for statement",
    dscr = "Insert a for statement",
  }, {
    t("for "),
    i(1, "i"),
    t("="),
    i(2, "1"),
    t(","),
    i(3, "10"),
    t({ " do", "\t" }),
    i(4),
    t({ "", "end" }),
  }),
  s({
    trig = "forp",
    name = "for in pairs statement",
    dscr = "Insert a for in pairs statement",
  }, {
    t("for "),
    i(1, "k"),
    t(","),
    i(2, "v"),
    t(" in pairs("),
    i(3, "table"),
    t({ ") do", "\t" }),
    i(4),
    t({ "", "end" }),
  }),
  s({
    trig = "fori",
    name = "for in ipairs statement",
    dscr = "Insert a for in ipairs statement",
  }, {
    t("for "),
    c(1, {
      i(1, "i"),
      i(1, "_"),
    }),
    t(","),
    i(2, "v"),
    t(" in ipairs("),
    i(3, "table"),
    t({ ") do", "\t" }),
    i(4),
    t({ "", "end" }),
  }),
  s({
    trig = "ret",
    name = "return statement",
    dscr = "Insert a return statement",
  }, {
    t("return "),
    i(1, "0"),
  }),
  s({
    trig = "fun",
    name = "function declaration",
    dscr = "Declare a new function",
  }, {
    c(1, {
      i(1, "local "),
      i(nil, ""),
    }),
    t("funcion "),
    i(2, "name"),
    t("("),
    d(3, rec_function_arg, {}),
    t({ ")", "\t" }),
    i(5),
    t({ "", "end" }),
  }),
  s({
    trig = "pr",
    name = "print",
    dscr = "Insert a print call",
  }, {
    t("print("),
    c(1, {
      i(1, "vim.inspect("),
      i(nil, ""),
    }),
    i(2, "\"Hello\""),
    f(function(args)
      if args and args[1] and args[1][1] ~= "" then
        return ")"
      end
      return ""
    end, { 1 }),
    t(")"),
  }),
  s({
    trig = "req",
    name = "require",
    dscr = "Insert a require call",
  }, {
    t("require(\""),
    i(1, "neokit"),
    t("\")"),
  }),
}, {}
