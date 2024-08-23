local ls = require("luasnip")
local s = ls.snippet
local p = require("luasnip.extras").partial

return {
  s({
    trig = "ymd",
    name = "Current date",
    dscr = "Insert the current date (y-m-d)",
  }, {
    p(os.date, "%Y-%m-%d"),
  }),
  s({
    trig = "dmy",
    name = "Current date",
    dscr = "Insert the current date (d-m-y)",
  }, {
    p(os.date, "%d-%m-%Y"),
  }),
  s({
    trig = "lorem",
    name = "Lorem Ipsum",
    dscr = "Insert Lorem Ipsum text",
  }, {
    t(
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    ),
  }),
}, {}
