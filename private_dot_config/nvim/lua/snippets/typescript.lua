local concat = require("neokit.array").concat
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

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
          t(": "),
          i(2, "string"),
          d(3, rec_function_arg, { 1 }),
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
        t(": "),
        i(3, "string"),
        t({ ";", "" }),
        d(4, rec_class_attr, {}),
      }),
    })
  )
end

local function rec_interface_attr()
  return sn(
    nil,
    c(1, {
      i(nil, ""),
      sn(nil, {
        t({ "", "\t" }),
        i(1, "attribute"),
        t(": "),
        i(2, "string"),
        t(";"),
        d(3, rec_interface_attr, {}),
      }),
    })
  )
end

ls.filetype_extend("typescript", { "javascript" })

return {
  s({
    trig = "fun",
    priority = 1001, -- Priority over javascript snippets
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
    t("): "),
    i(4, "string"),
    t({ " => {", "\t" }),
    i(6),
    d(5, function(args)
      if args[1][1] == "void" then
        return sn(nil, {})
      else
        return sn(nil, {
          t({ "", "\treturn " }),
          i(1, "0"),
          t(";"),
        })
      end
    end, { 4 }),
    t({ "", "};" }),
  }),
  s({
    trig = "class",
    priority = 1001, -- Priority over javascript snippets
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
  s({
    trig = "type",
    name = "type declaration",
    dscr = "Declare a new type",
  }, {
    c(1, {
      i(1, "export "),
      i(nil, ""),
    }),
    t("type "),
    i(2, "T"),
    t(" = "),
    i(3, "\"one\"|\"two\""),
    t(";"),
  }),
  s({
    trig = "int",
    name = "interface declaration",
    dscr = "Declare a new interface",
  }, {
    c(1, {
      i(1, "export "),
      i(nil, ""),
    }),
    t("interface "),
    i(2, "I"),
    t(" {"),
    d(3, rec_interface_attr, {}),
    t({ "", "}" }),
  }),
}, {}
