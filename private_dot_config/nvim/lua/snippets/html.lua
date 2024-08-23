local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local d = ls.dynamic_node

local function rec_table_column(_, _, _, column_start, column_end)
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        t({ "", "\t\t\t<" .. column_start .. ">" }),
        i(1, "Header"),
        t("</" .. column_end .. ">"),
        d(2, rec_table_column, {}, { user_args = { column_start, column_end } }),
      }),
    })
  )
end

local function rec_table_row()
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        t({ "", "\t\t<tr>" }),
        c(1, {
          sn(nil, {
            t({ "", "\t\t\t<th scope=\"row\">" }),
            i(1, "Header"),
            t("</th>"),
          }),
          i(nil, ""),
        }),
        d(2, rec_table_column, {}, { user_args = { "td", "td" } }),
        t({ "", "\t\t</tr>" }),
      }),
    })
  )
end

return {
  s({
    trig = "btn",
    name = "button HTML element",
    dscr = "Insert a button HTML element",
  }, {
    t("<button"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "button"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "button"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(3, {
      sn(nil, {
        t(" @click=\""),
        i(1, "onClick"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(4),
    t("</button>"),
  }),
  s({
    trig = "div",
    name = "div HTML element",
    dscr = "Insert a div HTML element",
  }, {
    t("<div"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "container"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</div>"),
  }),
  s({
    trig = "h1",
    name = "h1 HTML element",
    dscr = "Insert a title 1 HTML element",
  }, {
    t("<h1"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "title"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "title is-1"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</h1>"),
  }),
  s({
    trig = "h2",
    name = "h2 HTML element",
    dscr = "Insert a title 2 HTML element",
  }, {
    t("<h2"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "title"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "title is-2"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</h2>"),
  }),
  s({
    trig = "h3",
    name = "h3 HTML element",
    dscr = "Insert a title 3 HTML element",
  }, {
    t("<h3"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "title"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "title is-3"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</h3>"),
  }),
  s({
    trig = "h4",
    name = "h4 HTML element",
    dscr = "Insert a title 4 HTML element",
  }, {
    t("<h4"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "title"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "title is-4"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</h4>"),
  }),
  s({
    trig = "h5",
    name = "h5 HTML element",
    dscr = "Insert a title 5 HTML element",
  }, {
    t("<h5"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "title"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "title is-5"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</h5>"),
  }),
  s({
    trig = "h6",
    name = "h6 HTML element",
    dscr = "Insert a title 6 HTML element",
  }, {
    t("<h6"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "title"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "title is-6"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</h6>"),
  }),
  s({
    trig = "p",
    name = "p HTML element",
    dscr = "Insert a paragraph HTML element",
  }, {
    t("<p"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "text"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "has-text-centered"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(3),
    t("</p>"),
  }),
  s({
    trig = "a",
    name = "a HTML element",
    dscr = "Insert a link HTML element",
  }, {
    t("<a"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1, "link"),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(3, {
      sn(nil, {
        t(" href=\""),
        i(1),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(4, {
      sn(nil, {
        t(" @click=\""),
        i(1, "onClick"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(5),
    t("</a>"),
  }),
  s({
    trig = "span",
    name = "span HTML element",
    dscr = "Insert a span HTML element",
  }, {
    t("<span"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(3, {
      sn(nil, {
        t(" @click=\""),
        i(1, "onClick"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(">"),
    i(4),
    t("</span>"),
  }),
  s({
    trig = "img",
    name = "img HTML element",
    dscr = "Insert an img HTML element",
  }, {
    t("<img"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "image is-32x32"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(" src=\""),
    i(3, "@/assets/"),
    t("\""),
    t(" alt=\""),
    i(4),
    t("\""),
    t(" />"),
  }),
  s({
    trig = "in",
    name = "input HTML element",
    dscr = "Insert an input HTML element",
  }, {
    t("<input"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1),
        t("\""),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1, "input"),
        t("\""),
      }),
      i(nil, ""),
    }),
    t(" type=\""),
    i(3, "text"),
    t("\""),
    t(" name=\""),
    i(4),
    t("\""),
    t(" placeholder=\""),
    i(5),
    t("\""),
    t(" />"),
  }),
  s({
    trig = "tbl",
    name = "tbl HTML element",
    dscr = "Insert a table HTML element",
  }, {
    t("<table>"),
    c(1, {
      sn(nil, {
        t({ "", "\t<caption>", "\t\t" }),
        i(1),
        t({ "", "\t</caption>" }),
      }),
      i(nil, ""),
    }),
    c(2, {
      sn(nil, {
        t({ "", "\t<thead>" }),
        t({ "", "\t\t<tr>" }),
        d(1, rec_table_column, {}, { user_args = { "th scope=\"col\"", "th" } }),
        t({ "", "\t\t</tr>" }),
        t({ "", "\t</thead>" }),
      }),
      i(nil, ""),
    }),
    t({ "", "\t<tbody>" }),
    d(3, rec_table_row, {}),
    t({ "", "\t</tbody>" }),
    c(4, {
      sn(nil, {
        t({ "", "\t<tfoot>" }),
        t({ "", "\t\t<tr>" }),
        c(1, {
          sn(nil, {
            t({ "", "\t\t\t<th scope=\"row\">" }),
            i(1, "Header"),
            t("</th>"),
          }),
          i(nil, ""),
        }),
        d(2, rec_table_column, {}, { user_args = { "td", "td" } }),
        t({ "", "\t\t</tr>" }),
        t({ "", "\t</tfoot>" }),
      }),
      i(nil, ""),
    }),
    t({ "", "</table>" }),
  }),
  s({
    trig = "doct",
    name = "doctype",
    dscr = "Insert a DocType tag",
  }, {
    t("<!DOCTYPE HTML>"),
  }),
  s({
    trig = ".",
    name = "class",
    dscr = "Insert the class attribute",
  }, {
    t("class=\""),
    i(1),
    t("\""),
  }),
  s({
    trig = "#",
    name = "id",
    dscr = "Insert the id attribute",
  }, {
    t("id=\""),
    i(1),
    t("\""),
  }),
  s({
    trig = "mailto",
    name = "mailto link",
    dscr = "Insert a mailto link",
  }, {
    t("<a href=\"mailto:"),
    i(1, "joe@example.com"),
    c(2, {
      sn(nil, {
        t("?subject="),
        i(1, "feedback request"),
      }),
      i(nil, ""),
    }),
    t("\">"),
    i(3, "Email me"),
    t("</a>"),
  }),
}, {
  s({
    trig = "//",
    name = "comment",
    dscr = "Insert a comment",
  }, {
    t("<!-- "),
    i(1),
    t(" -->"),
  }),
}
