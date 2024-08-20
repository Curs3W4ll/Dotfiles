local concat = require("neokit.array").concat
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
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
          c(1, {
            i(1, "std::string"),
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

local function reuse(args)
  return args[1][1]
end

ls.filetype_extend("cpp", { "c" })

return {
  s({
    trig = "fun",
    priority = 1001, -- Priority over C snippet
    name = "function declaration",
    dscr = "Declare a new function",
  }, {
    c(1, {
      i(1, "void"),
      i(1, "std::string"),
      i(1, "char"),
      i(1, "int"),
      i(1, "short"),
      i(1, "long"),
    }),
    t(" "),
    i(2, "function"),
    t("("),
    d(3, rec_function_arg, {}),
    t(")"),
    c(4, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    t({ "", "{", "\t" }),
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
    end, { 1 }),
    t({ "", "}" }),
  }),
  s({
    trig = "nsp",
    name = "namespace declaration",
    dscr = "Insert a namespace declaration",
  }, {
    t("namespace "),
    i(1, "std"),
    t({ " {", "", "" }),
    i(2),
    t({ "", "", "} // namespace " }),
    f(reuse, { 1 }),
  }),
  s({
    trig = "class",
    name = "class declaration",
    dscr = "Insert a class declaration",
  }, {
    t("class "),
    i(1, "C"),
    t({ " {", "\tpublic:", "\t\t" }),
    f(reuse, { 1 }),
    t("("),
    i(2),
    t(")"),
    c(3, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(4, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\t" }),
    f(reuse, { 1 }),
    t("("),
    f(reuse, { 1 }),
    t(" const& other)"),
    c(5, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(6, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\t" }),
    f(reuse, { 1 }),
    t("("),
    f(reuse, { 1 }),
    t("&& other)"),
    c(7, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(8, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\t~" }),
    f(reuse, { 1 }),
    t("() noexcept"),
    c(9, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "", "\t\t" }),
    f(reuse, { 1 }),
    t("& operator=("),
    f(reuse, { 1 }),
    t(" const& other)"),
    c(10, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(11, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\t" }),
    f(reuse, { 1 }),
    t("& operator=("),
    f(reuse, { 1 }),
    t("&& other)"),
    c(12, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(13, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t({ ";", "\tprotected:", "\tprivate:", "};" }),
  }),
  s({
    trig = "iclass",
    name = "interface declaration",
    dscr = "Insert a interface class declaration",
  }, {
    t("class I"),
    i(1, "C"),
    t({ " {", "\tpublic:", "\t\tI" }),
    f(reuse, { 1 }),
    t("("),
    i(2),
    t(")"),
    c(3, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(4, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tI" }),
    f(reuse, { 1 }),
    t("(I"),
    f(reuse, { 1 }),
    t(" const& other)"),
    c(5, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(6, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tI" }),
    f(reuse, { 1 }),
    t("(I"),
    f(reuse, { 1 }),
    t("&& other)"),
    c(7, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(8, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tvirtual ~I" }),
    f(reuse, { 1 }),
    t("() noexcept"),
    c(9, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "", "\t\tI" }),
    f(reuse, { 1 }),
    t("& operator=(I"),
    f(reuse, { 1 }),
    t(" const& other)"),
    c(10, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(11, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tI" }),
    f(reuse, { 1 }),
    t("& operator=(I"),
    f(reuse, { 1 }),
    t("&& other)"),
    c(12, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(13, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t({ ";", "\tprotected:", "\tprivate:", "};" }),
  }),
  s({
    trig = "aclass",
    name = "abstract class declaration",
    dscr = "Insert a abstract class declaration",
  }, {
    t("class A"),
    i(1, "C"),
    t({ " {", "\tpublic:", "\t\tA" }),
    f(reuse, { 1 }),
    t("("),
    i(2),
    t(")"),
    c(3, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(4, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tA" }),
    f(reuse, { 1 }),
    t("(A"),
    f(reuse, { 1 }),
    t(" const& other)"),
    c(5, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(6, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tA" }),
    f(reuse, { 1 }),
    t("(A"),
    f(reuse, { 1 }),
    t("&& other)"),
    c(7, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(8, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tvirtual ~A" }),
    f(reuse, { 1 }),
    t("() noexcept"),
    c(9, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "", "\t\tA" }),
    f(reuse, { 1 }),
    t("& operator=(A"),
    f(reuse, { 1 }),
    t(" const& other)"),
    c(10, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(11, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t(";"),
    t({ "", "\t\tA" }),
    f(reuse, { 1 }),
    t("& operator=(A"),
    f(reuse, { 1 }),
    t("&& other)"),
    c(12, {
      i(1, " noexcept"),
      i(nil, ""),
    }),
    c(13, {
      i(1, " = default"),
      i(1, " = delete"),
      i(nil, ""),
    }),
    t({ ";", "\tprotected:", "\tprivate:", "};" }),
  }),
  s({
    trig = "errclass",
    name = "error class declaration",
    dscr = "Insert an error class declaration",
  }, {
    t("class "),
    i(1),
    t({ "Error: public std::exception {", "\tpublic:", "\t\t" }),
    f(reuse, { 1 }),
    t({ "Error() noexcept = delete;", "\t\texplicit " }),
    f(reuse, { 1 }),
    t({ "Error(std::string const& message);", "\t\t" }),
    f(reuse, { 1 }),
    t("Error("),
    f(reuse, { 1 }),
    t({ "Error const& other) = default;", "\t\t" }),
    f(reuse, { 1 }),
    t("Error("),
    f(reuse, { 1 }),
    t({ "Error&& other) = default;", "\t\t~" }),
    f(reuse, { 1 }),
    t({ "Error() override = default;", "", "\t\t" }),
    f(reuse, { 1 }),
    t("Error& operator=("),
    f(reuse, { 1 }),
    t({ "Error const& other) = default;", "\t\t" }),
    f(reuse, { 1 }),
    t("Error& operator=("),
    f(reuse, { 1 }),
    t({
      "Error&& other) = default;",
      "",
      "\t\tconst char* what() const noexcept override;",
      "",
      "\tprotected:",
      "\t\tstd::string message;",
      "};",
    }),
  }),
  s({
    trig = "cout",
    name = "information print",
    dscr = "Print information using cout or cerr",
  }, {
    t("std::"),
    c(1, {
      i(1, "cout"),
      i(1, "err"),
    }),
    t(" << "),
    i(2),
    t(" << std::endl;"),
  }),
  s({
    trig = "cast",
    name = "cast statement",
    dscr = "Insert a cast statement",
  }, {
    t("static_cast<"),
    i(1, "std::string"),
    t(">("),
    i(2, "value"),
    t(")"),
  }),
  s({
    trig = "fore",
    name = "for each loop",
    dscr = "Insert a for each elem loop",
  }, {
    t("for ("),
    c(1, {
      t("const "),
      i(nil, ""),
    }),
    t("auto"),
    c(2, {
      t("& "),
      t(" "),
    }),
    i(3, "elem"),
    t(" : "),
    i(4, "elems"),
    t({ ") {", "\t" }),
    i(5),
    t({ "", "}" }),
  }),
  s({
    trig = "iter",
    name = "for loop to iterate",
    dscr = "Insert a for loop to iterate through a value",
  }, {
    t("for ("),
    c(1, {
      i(1, "const "),
      i(nil, ""),
    }),
    t("auto "),
    i(2, "i"),
    t(" = "),
    i(3, "container"),
    t("."),
    f(function(args)
      if args and args[1] and args[1][1] ~= "" then
        return "c"
      else
        return ""
      end
    end, { 1 }),
    t("begin(); "),
    f(reuse, { 2 }),
    t(" != "),
    f(reuse, { 3 }),
    t("."),
    f(function(args)
      if args and args[1] and args[1][1] ~= "" then
        return "c"
      else
        return ""
      end
    end, { 1 }),
    t("end(); "),
    f(reuse, { 2 }),
    t({ "++) {", "\t" }),
    i(4),
    t({ "", "}" }),
  }),
  s({
    trig = "ld",
    name = "lambda",
    dscr = "Insert a lambda function",
  }, {
    t("["),
    c(1, {
      i(1, "&"),
      i(1, "i"),
    }),
    t("]("),
    c(2, {
      i(1, "int n"),
      i(nil, ""),
    }),
    t(") { "),
    i(3),
    t(" }"),
  }),
}, {
  s({
    trig = "^inc",
    trigEngine = "pattern",
    priority = 1001, -- Priority over C snippet
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
    d(3, function(args)
      if args[1][1] == "<" then
        return sn(nil, {})
      else
        return sn(nil, {
          t("."),
          i(1, "hpp"),
        })
      end
    end, { 2 }),
    f(function(args)
      if args[1][1] == "<" then
        return ">"
      else
        return args[1][1]
      end
    end, { 2 }),
  }),
}
