local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

return {
  s({
    trig = "steps",
    name = "steps scope",
    dscr = "Insert a steps statement",
  }, {
    t({ "steps {", "\t" }),
    i(1),
    t({ "", "}" }),
  }),
  s({
    trig = "stage",
    name = "stage scope",
    dscr = "Insert a stage statement",
  }, {
    t("stage(\""),
    i(1, "Test"),
    t({ "\") {", "\t" }),
    i(2),
    t({ "", "}" }),
  }),
  s({
    trig = "pipe",
    name = "pipeline scope",
    dscr = "Insert a pipeline statement",
  }, {
    t({ "pipeline {", "\tagent any", "\tstages {", "\t\t" }),
    i(1),
    t({ "", "\t}", "}" }),
  }),
  s({
    trig = "sample",
    name = "sample code",
    dscr = "Insert a sample set of statements",
  }, {
    t({ "pipeline {", "\tagent any", "\tstages {", "\t\tstage(\"" }),
    i(1, "Build"),
    t({ "\") {", "\t\t\tsteps {", "\t\t\t\tsh \"" }),
    i(2, "make"),
    t({ "\"", "\t\t\t}", "\t\t}", "\t\tstage(\"" }),
    i(3, "Test"),
    t({ "\") {", "\t\t\tsteps {", "\t\t\t\tsh \"" }),
    i(4, "make test"),
    t({ "\"", "\t\t\t\tjunit \"" }),
    i(5, "reports/**/*.xml"),
    t({ "\"", "\t\t\t}", "\t\t}", "\t\tstage(\"" }),
    i(6, "Deploy"),
    t({ "\") {", "\t\t\tsteps {", "\t\t\t\tsh \"" }),
    i(7, "make publish"),
    t({ "\"", "\t\t\t}", "\t\t}", "\t}", "}" }),
  }),
  s({
    trig = "d",
    name = "docker",
    dscr = "Insert a docker statement",
  }, {
    t({ "docker {", "\timage \"" }),
    i(1, "myregistry.com/node"),
    c(2, {
      sn(nil, {
        t({ "\"", "\tlabel \"" }),
        i(1, "my-defined-label"),
      }),
      i(nil, ""),
    }),
    t({ "\"", "\tregistryUrl \"" }),
    i(3, "https://myregistry.com"),
    t({ "\"", "\tregistryCredentialsId \"" }),
    i(4, "myPredefinedCredentialsInJenkins"),
    t({ "\"", "}" }),
  }),
  s({
    trig = "df",
    name = "dockerfile",
    dscr = "Insert a dockerfile statement",
  }, {
    t({ "dockerfile {", "\tfilename \"" }),
    i(1, "Dockerfile"),
    t({ "\"", "\tdir \"" }),
    i(2, "build"),
    c(3, {
      sn(nil, {
        t({ "\"", "\tlabel \"" }),
        i(1, "my-defined-label"),
      }),
      i(nil, ""),
    }),
    t({ "\"", "\tregistryUrl \"" }),
    i(4, "https://myregistry.com"),
    t({ "\"", "\tregistryCredentialsId \"" }),
    i(5, "myPredefinedCredentialsInJenkins"),
    t({ "\"", "}" }),
  }),
  s({
    trig = "pa",
    name = "post always",
    dscr = "Insert a post always statements",
  }, {
    t({ "post {", "\t" }),
    c(1, {
      i(1, "always"),
      i(1, "changed"),
      i(1, "fixed"),
      i(1, "regression"),
      i(1, "aborted"),
      i(1, "failure"),
      i(1, "success"),
      i(1, "unstable"),
      i(1, "cleanup"),
    }),
    t({ " {", "\t\t" }),
    i(2),
    t({ "", "\t}", "}" }),
  }),
}, {}
