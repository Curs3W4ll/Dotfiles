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
          c(1, {
            i(1, "char"),
            i(1, "int"),
            i(1, "short"),
            i(1, "long"),
          }),
          t(" "),
          c(2, {
            i(1, "var"),
          }),
          d(3, rec_function_arg, { 1 }),
        })
      ),
    })
  )
end

return {
  s({
    trig = "main",
    name = "base main function",
    dscr = "Create a base main function",
  }, {
    t("int main("),
    c(1, {
      t("int ac, char const *const av[]"),
      i(nil, ""),
    }),
    t({ ")", "{", "\t" }),
    c(3, {
      i(nil, ""),
      sn(nil, {
        i(1),
        t({ "", "\t" }),
      }),
    }),
    t("return "),
    i(2, "0"),
    t({ ";", "}" }),
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
      i(1, "void"),
      i(1, "char"),
      i(1, "short"),
      i(1, "int"),
      i(1, "long"),
    }),
    t(" "),
    i(2, "function"),
    t("("),
    d(3, rec_function_arg, {}),
    t({ ")", "{", "\t" }),
    i(5),
    d(4, function(args)
      if args[1][1] == "void" then
        return sn(nil, {})
      else
        return sn(nil, {
          t({ "", "\treturn " }),
          i(1, "0"),
          t(";"),
        })
      end
    end, { 1 }),
    t({ "", "}" }),
  }),
  s({
    trig = "dfun",
    name = "function prototype",
    dscr = "Insert a function prototype",
  }, {
    c(1, {
      i(1, "void"),
      i(1, "char"),
      i(1, "int"),
      i(1, "long"),
    }),
    t(" "),
    i(2, "function"),
    t("("),
    d(3, rec_function_arg, {}),
    t(");"),
  }),
  s({
    trig = "struct",
    name = "strcut declaration",
    dscr = "Declare a new structure",
  }, {
    t("typedef struct "),
    i(1, "struct_name"),
    t({ "_s {", "\t" }),
    i(2),
    t({ "", "} " }),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t("_t;"),
  }),
  s({
    trig = "llist",
    name = "linked list declaration",
    dscr = "Declare a linked list structure",
  }, {
    t("typedef struct "),
    i(1, "struct_name"),
    t({ "_s {", "\t" }),
    i(2),
    t({ "", "\tstruct " }),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t({ "_s* next;", "} " }),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t("_t;"),
  }),
  s({
    trig = "enum",
    name = "enum declaration",
    dscr = "Declare an enum",
  }, {
    t({ "typedef enum {", "\t" }),
    i(2),
    t({ "", "} " }),
    i(1, "name"),
    t("_t;"),
  }),
  s({
    trig = "pr",
    name = "print",
    dscr = "Insert a print call",
  }, {
    t("printf(\""),
    i(1, "%s"),
    t("\\n\""),
    i(2),
    t(");"),
  }),
}, {
  s({
    trig = "^inc",
    trigEngine = "pattern",
    hidden = true,
    name = "include line",
    dscr = "Insert a line to include a lib",
  }, {
    t("#include "),
    c(2, {
      i(1, "<"),
      i(1, "\""),
    }),
    i(1, "lib"),
    t("."),
    i(3, "h"),
    f(function(args)
      if args[1][1] == "<" then
        return ">"
      else
        return args[1][1]
      end
    end, { 2 }),
  }),
  s({
    trig = "^prag",
    trigEngine = "pattern",
    hidden = true,
    name = "pragma header",
    dscr = "Insert a pragma header",
  }, {
    t("#pragma "),
    i(1, "once"),
  }),
  s({
    trig = "^unused",
    trigEngine = "pattern",
    hidden = true,
    name = "unused macro",
    dscr = "Insert the unused macros for variable",
  }, {
    t("#define UNUSED __attribute__((unused))"),
  }),
}
