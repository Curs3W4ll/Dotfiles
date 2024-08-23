local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local function reuse(args)
  return args[1][1]
end

return {
  s({
    trig = "init",
    name = "base file structure",
    dscr = "Insert a classic set of statements",
  }, {
    t("cmake_minimum_required(VERSION "),
    i(1, "2.8.2"),
    t({ ")", "project(" }),
    i(2, "ProjectName"),
    t({ ")", "", "find_package(" }),
    i(3, "library"),
    t({ ")", "", "include_directories(" }),
    f(reuse, { 3 }),
    t({ "_INCLUDE_DIRS)", "", "add_subdirectory(" }),
    i(4, "src"),
    t({ ")", "", "add_executable(" }),
    f(reuse, { 2 }),
    t({ ")", "", "target_link_libraries(" }),
    f(reuse, { 2 }),
    t(" ${"),
    f(reuse, { 3 }),
    t("_LIBRARIES})"),
  }),
  s({
    trig = "min",
    name = "min statement",
    dscr = "Insert a minimum cmake version",
  }, {
    t("cmake_minimum_required(VERSION "),
    i(1, "2.8.2"),
    t(")"),
  }),
  s({
    trig = "inc",
    name = "include directory",
    dscr = "Insert an include directory statement",
  }, {
    t("include_directories(${"),
    i(1, "include_dir"),
    t("})"),
  }),
  s({
    trig = "find",
    name = "find package",
    dscr = "Insert a find package statement",
  }, {
    t("find_package("),
    i(1, "library"),
    c(2, {
      i(1, " REQUIRED"),
      i(nil, ""),
    }),
    t(")"),
  }),
  s({
    trig = "sdir",
    name = "sub directory",
    dscr = "Insert a sub directory statement",
  }, {
    t("add_subdirectory("),
    i(1, "src"),
    t(")"),
  }),
  s({
    trig = "lib",
    name = "library",
    dscr = "Insert a library statement",
  }, {
    t("add_library("),
    i(1, "lib"),
    t(" ${"),
    i(2, "srcs"),
    t("})"),
  }),
  s({
    trig = "link",
    name = "link libraries",
    dscr = "Insert a link libraries statement",
  }, {
    t("target_link_libraries("),
    i(1, "bin"),
    t(" "),
    i(2, "lib"),
    t(")"),
  }),
  s({
    trig = "exturl",
    name = "external url",
    dscr = "Insert an external URL statement",
  }, {
    t({ "include(ExternalProject)", "ExternalProject_Add(" }),
    i(1, "googletest"),
    t({ "", "\tURL " }),
    i(2, "http://googletest.googlecode.com/files/gtest-1.7.0.zip"),
    t({ "", "\tURL_HASH SHA1=" }),
    i(3, "f85f6d2481e2c6c4a18539e391aa4ea8ab0394af"),
    t({ "", "\tSOURCE_DIR \"" }),
    i(4, "${CMAKE_BINARY_DIR}/gtest-src"),
    t({ "\"", "\tBINARY_DIR \"" }),
    i(5, "${CMAKE_BINARY_DIR}/gtest-build"),
    t({ "\"", "\tCONFIGURE_COMMAND \"" }),
    i(6),
    t({ "\"", "\tBUILD_COMMAND \"" }),
    i(7),
    t({ "\"", "\tINSTALL_COMMAND \"" }),
    i(8),
    t({ "\"", "\tTEST_COMMAND \"" }),
    i(9),
    t({ "\"", ")" }),
  }),
  s({
    trig = "extgit",
    name = "external git",
    dscr = "Insert an external Git statement",
  }, {
    t({ "include(ExternalProject)", "ExternalProject_Add(" }),
    i(1, "googletest"),
    t({ "", "\tGIT_REPOSITORY " }),
    i(2, "https://github.com/google/googletest.git"),
    t({ "", "\tGIT_TAG " }),
    i(3, "master"),
    t({ "", "\tSOURCE_DIR \"" }),
    i(4, "${CMAKE_BINARY_DIR}/googletest-src"),
    t({ "\"", "\tBINARY_DIR \"" }),
    i(5, "${CMAKE_BINARY_DIR}/googletest-build"),
    t({ "\"", "\tCONFIGURE_COMMAND \"" }),
    i(6),
    t({ "\"", "\tBUILD_COMMAND \"" }),
    i(7),
    t({ "\"", "\tINSTALL_COMMAND \"" }),
    i(8),
    t({ "\"", "\tTEST_COMMAND \"" }),
    i(9),
    t({ "\"", ")" }),
  }),
  s({
    trig = "props",
    name = "target properties",
    dscr = "Insert a target properties statement",
  }, {
    t("set_target_properties("),
    i(1, "target"),
    t({ "", "\t" }),
    i(2, "properties"),
    t(" "),
    i(3, "compile_flags"),
    t({ "", "\t" }),
    i(4, "\"-O3 -Wall -pedantic\""),
    t({ "", ")" }),
  }),
}, {}
