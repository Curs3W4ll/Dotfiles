local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

return {
  s({
    trig = "def",
    name = "default goal",
    dscr = "Insert the default goal custom definition",
  }, {
    t({ "# Default target", ".DEFAULT_GOAL := " }),
    i(1, "all"),
  }),
  s({
    trig = "tar",
    name = "new target",
    dscr = "Insert a new target definition",
  }, {
    t(".PHONY: "),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t({ "", "" }),
    i(1, "build"),
    t(": "),
    i(2),
    f(function(args)
      if args and args[1] and args[1][1] ~= "" then
        return " "
      end
      return ""
    end, { 2 }),
    t("# "),
    i(3, "Description"),
    t({ "", "\t" }),
    i(4),
  }),
  s({
    trig = "if",
    name = "if statement",
    dscr = "Insert if eq statement",
  }, {
    t("ifeq ("),
    i(1, "val1"),
    t(", "),
    i(2, "val2"),
    t({ ")", "\t" }),
    i(3),
    c(4, {
      sn(nil, {
        t({ "", "else", "\t" }),
        i(1),
      }),
      i(nil, ""),
    }),
    t({ "", "endif" }),
  }),
  s({
    trig = "help",
    name = "help target",
    dscr = "Insert a target to display an help message",
  }, {
    t({
      ".PHONY: help",
      "help: # Print help on Makefile",
      "\t@grep '^[^.#]\\+:\\s\\+.*#' Makefile | sed \"s/\\(.*\\):\\s*\\( *\\)\\(.*\\) #\\s*\\(.*\\)/`printf \"\\033[93m\"`\\1`printf \"\\033[0m\"`\\t\\4 [\\3]/\" | expand -t20",
    }),
  }),
}, {}
