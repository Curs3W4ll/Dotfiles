local isStringBeforeCursor = require("neokit.vim").isStringBeforeCursor
local concat = require("neokit.array").concat
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node
local d = ls.dynamic_node

local function rec_prop()
  return sn(
    nil,
    c(1, {
      t(nil),
      sn(nil, {
        t({ "", "\t" }),
        i(1, "prop1"),
        c(2, {
          t("?"),
          t(""),
        }),
        t(": "),
        c(3, {
          i(1, "string"),
          i(2, "boolean"),
          i(3, "number"),
        }),
        t(";"),
        d(4, rec_prop, {}),
      }),
    })
  )
end

local function default_props(args)
  local result = {}
  local idx = 1
  for _, elem in ipairs(args[1]) do
    if string.len(elem) > 0 then
      local name, type = elem:sub(1, -2):match("(.*):(.*)")
      if name:sub(-1) == "?" then
        type = type:sub(2)
        table.insert(result, t(name))
        table.insert(result, t(": "))
        if type == "number" then
          table.insert(result, i(idx, "10"))
        elseif type == "boolean" then
          table.insert(
            result,
            c(idx, {
              i(1, "true"),
              i(2, "false"),
            })
          )
        else
          table.insert(result, t("\""))
          table.insert(result, i(idx, "string"))
          table.insert(result, t("\""))
        end
        idx = idx + 1
        table.insert(result, t({ ",", "" }))
      end
    end
  end
  return sn(nil, result)
end

local function rec_emit_param(args)
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
          i(1, "param"),
          t(": "),
          c(2, {
            i(1, "string"),
            i(2, "boolean"),
            i(3, "number"),
          }),
          d(3, rec_emit_param, { 1 }),
        })
      ),
    })
  )
end

local function rec_emit()
  return sn(
    nil,
    c(1, {
      i(nil, ""),
      sn(nil, {
        t({ "", "\t" }),
        i(1, "emit1"),
        t(": ["),
        d(2, rec_emit_param, {}),
        t("];"),
        d(3, rec_emit, {}),
      }),
    })
  )
end

local function rec_expose()
  return sn(
    nil,
    c(1, {
      i(nil, ""),
      sn(nil, {
        t({ "", "\t" }),
        i(1, "exposed"),
        t(","),
        d(2, rec_expose, {}),
      }),
    })
  )
end

local function rec_slot_prop(args)
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
          t(" "),
          i(1, "prop1"),
          t(": "),
          c(2, {
            i(1, "string"),
            i(2, "boolean"),
            i(3, "number"),
          }),
          d(3, rec_emit_param, { 1 }),
        })
      ),
    })
  )
end

local function rec_slot()
  return sn(
    nil,
    c(1, {
      i(nil, ""),
      sn(nil, {
        t({ "", "\t" }),
        i(1, "default"),
        t("(props: {"),
        d(2, rec_slot_prop, {}),
        t(" }): any;"),
        d(3, rec_slot, {}),
      }),
    })
  )
end

ls.filetype_extend("vue", { "css", "html", "javascript", "typescript" })

return {
  s({
    trig = "ib",
    name = "Import composable",
    dscr = "Import a composable",
  }, {
    t({ "import { " }),
    i(1),
    t({ " } from \"@/composables/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t("\";"),
  }),
  s({
    trig = "id",
    name = "Import directive",
    dscr = "Import a directive",
  }, {
    t({ "import { " }),
    i(1),
    t({ " } from \"@/directives/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t("\";"),
  }),
  s({
    trig = "ic",
    name = "Import component",
    dscr = "Import a component",
  }, {
    t({ "import " }),
    i(1),
    t({ " from \"@/components/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t(".vue\";"),
  }),
  s({
    trig = "ip",
    name = "Import page",
    dscr = "Import a page",
  }, {
    t({ "import " }),
    i(1),
    t({ " from \"@/pages/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t(".vue\";"),
  }),
  s({
    trig = "iv",
    name = "Import view",
    dscr = "Import a view",
  }, {
    t({ "import " }),
    i(1),
    t({ " from \"@/views/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t(".vue\";"),
  }),
  s({
    trig = "is",
    name = "Import store",
    dscr = "Import a store",
  }, {
    t({ "import { " }),
    i(1),
    t({ " } from \"@/stores/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t("\";"),
  }),
  s({
    trig = "it",
    name = "Import type",
    dscr = "Import a type",
  }, {
    t({ "import { " }),
    i(1),
    t({ " } from \"@/types/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t("\";"),
  }),
  s({
    trig = "iu",
    name = "Import util",
    dscr = "Import a util",
  }, {
    t({ "import { " }),
    i(1),
    t({ " } from \"@/utils/" }),
    f(function(args)
      return args[1]
    end, { 1 }),
    i(2),
    t("\";"),
  }),
  s({
    trig = "props",
    name = "props definition",
    dscr = "Define the props of a component",
  }, {
    c(1, {
      t("const props = "),
      i(nil, ""),
    }),
    t("defineProps<{"),
    d(2, rec_prop, {}),
    t({ "", "}>();" }),
  }),
  s({
    trig = "propsd",
    name = "props definition with defaults",
    dscr = "Define the props of a component with default values",
  }, {
    c(1, {
      t("const props = "),
      i(nil, ""),
    }),
    t("withDefaults("),
    t("defineProps<{"),
    d(2, rec_prop, {}),
    t({ "", "}>(), {", "" }),
    d(3, default_props, { 2 }),
    t({ "});" }),
  }),
  s({
    trig = "model",
    name = "model definition",
    dscr = "Define a model of a component",
  }, {
    t("const "),
    i(1, "modelValue"),
    t(" = defineModel<"),
    c(2, {
      i(1, "string"),
      i(2, "boolean"),
      i(3, "number"),
    }),
    t(">("),
    c(3, {
      sn(nil, {
        t("\""),
        i(1, "custom"),
        t("\""),
      }),
      i(nil, ""),
    }),
    d(4, function(args)
      local separators = {}
      if args[1][1] ~= "" then
        table.insert(separators, t(", "))
      end
      return sn(nil, {
        c(1, {
          i(nil, ""),
          sn(
            nil,
            concat(separators, {
              t("{ "),
              c(1, {
                sn(nil, {
                  t("default: "),
                  i(1, "value"),
                  t(", "),
                }),
                i(nil, ""),
              }),
              c(2, {
                i(nil, ""),
                sn(nil, {
                  t("required: "),
                  c(1, {
                    i(1, "true"),
                    i(1, "false"),
                  }),
                  t(", "),
                }),
              }),
              t(" }"),
            })
          ),
        }),
      })
    end, { 3 }),
    t(");"),
  }),
  s({
    trig = "emits",
    name = "emits definition",
    dscr = "Define the emits of a component",
  }, {
    c(1, {
      t("const emit = "),
      i(nil, ""),
    }),
    t("defineEmits<{"),
    d(2, rec_emit, {}),
    t({ "", "}>();" }),
  }),
  s({
    trig = "ref",
    name = "ref var",
    dscr = "Define a new ref var",
  }, {
    t("const "),
    i(1, "var"),
    t(" = ref("),
    i(2, "value"),
    t(");"),
  }),
  s({
    trig = "computed",
    name = "computed var",
    dscr = "Define a new computed var",
  }, {
    t("const "),
    i(1, "computedVar"),
    t(" = computed(() => {"),
    t({ "", "\treturn " }),
    i(2, "value"),
    t({ ";", "});" }),
  }),
  s({
    trig = "watch",
    name = "watcher",
    dscr = "Define a new watcher",
  }, {
    t("watch("),
    c(1, {
      i(1, "watchedValue"),
      sn(nil, {
        c(1, {
          i(nil, ""),
          i(1, "async "),
        }),
        t("() => "),
        i(2, "somethingToWatch"),
      }),
    }),
    t(", "),
    c(2, {
      i(nil, ""),
      i(1, "async "),
    }),
    t("("),
    i(4, "value"),
    t(", "),
    i(5, "prevValue"),
    t({ ") => {", "\t" }),
    i(3),
    t({ "", "});" }),
  }),
  s({
    trig = "mounted",
    name = "mounted event",
    dscr = "Create a listener for the mounted event",
  }, {
    t("onMounted("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "beforemount",
    name = "beforeMount event",
    dscr = "Create a listener for the beforeMount event",
  }, {
    t("onBeforeMount("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "updated",
    name = "updated event",
    dscr = "Create a listener for the updated event",
  }, {
    t("onUpdated("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "beforeupdate",
    name = "beforeUpdate event",
    dscr = "Create a listener for the beforeUpdate event",
  }, {
    t("onBeforeUpdate("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "unmounted",
    name = "unmounted event",
    dscr = "Create a listener for the unmounted event",
  }, {
    t("onUnmounted("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "beforeunmount",
    name = "beforeUnmount event",
    dscr = "Create a listener for the beforeUnmount event",
  }, {
    t("onBeforeUnmount("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "errorcaptured",
    name = "errorCaptured event",
    dscr = "Create a listener for the errorCaptured event",
  }, {
    t("onErrorCaptured("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t("("),
    c(2, {
      i(nil, ""),
      sn(nil, {
        i(1, "err"),
        c(2, {
          i(nil, ""),
          sn(nil, {
            t(", "),
            i(1, "instance"),
            c(2, {
              i(nil, ""),
              sn(nil, {
                t(", "),
                i(1, "info"),
              }),
            }),
          }),
        }),
      }),
    }),
    t({ ") => {", "\t" }),
    i(3),
    t({ "", "});" }),
  }),
  s({
    trig = "rendertracked",
    name = "renderTracked event",
    dscr = "Create a listener for the renderTracked event",
  }, {
    t("onRenderTracked("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t("("),
    c(2, {
      i(nil, ""),
      sn(nil, {
        i(1, "effect"),
        c(2, {
          i(nil, ""),
          sn(nil, {
            t(", "),
            i(1, "target"),
            c(2, {
              i(nil, ""),
              sn(nil, {
                t(", "),
                i(1, "type"),
                c(2, {
                  i(nil, ""),
                  sn(nil, {
                    t(", "),
                    i(1, "key"),
                  }),
                }),
              }),
            }),
          }),
        }),
      }),
    }),
    t({ ") => {", "\t" }),
    i(3),
    t({ "", "});" }),
  }),
  s({
    trig = "rendertriggered",
    name = "renderTriggered event",
    dscr = "Create a listener for the renderTriggered event",
  }, {
    t("onRenderTriggered("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t("("),
    c(2, {
      i(nil, ""),
      sn(nil, {
        i(1, "effect"),
        c(2, {
          i(nil, ""),
          sn(nil, {
            t(", "),
            i(1, "target"),
            c(2, {
              i(nil, ""),
              sn(nil, {
                t(", "),
                i(1, "type"),
                c(2, {
                  i(nil, ""),
                  sn(nil, {
                    t(", "),
                    i(1, "key"),
                    c(2, {
                      i(nil, ""),
                      sn(nil, {
                        t(", "),
                        i(1, "newValue"),
                        c(2, {
                          i(nil, ""),
                          sn(nil, {
                            t(", "),
                            i(1, "oldValue"),
                            c(2, {
                              i(nil, ""),
                              sn(nil, {
                                t(", "),
                                i(1, "key"),
                              }),
                            }),
                          }),
                        }),
                      }),
                    }),
                  }),
                }),
              }),
            }),
          }),
        }),
      }),
    }),
    t({ ") => {", "\t" }),
    i(3),
    t({ "", "});" }),
  }),
  s({
    trig = "activated",
    name = "activated event",
    dscr = "Create a listener for the activated event",
  }, {
    t("onActivated("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "deactivated",
    name = "deactivated event",
    dscr = "Create a listener for the deactivated event",
  }, {
    t("onDeactivated("),
    c(1, {
      i(nil, ""),
      i(1, "async "),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "serverprefetch",
    name = "serverPrefetch event",
    dscr = "Create a listener for the serverPrefetch event",
  }, {
    t("onServerPrefetch("),
    c(1, {
      i(1, "async "),
      i(nil, ""),
    }),
    t({ "() => {", "\t" }),
    i(2),
    t({ "", "});" }),
  }),
  s({
    trig = "expose",
    name = "expose definition",
    dscr = "Define the exposed elements of a component",
  }, {
    t("defineExpose({"),
    d(1, rec_expose, {}),
    t({ "", "});" }),
  }),
  s({
    trig = "slots",
    name = "slots definition",
    dscr = "Define the slots of a component",
  }, {
    t("defineSlots<{"),
    d(1, rec_slot, {}),
    t({ "", "}>();" }),
  }),
  s({
    trig = "script",
    name = "Vue script tag",
    dscr = "Insert a script tag in a vue file",
  }, {
    f(function()
      if isStringBeforeCursor("<") then
        return ""
      end
      return "<"
    end),
    t("script"),
    c(1, {
      i(1, " setup"),
      t(""),
    }),
    c(2, {
      sn(nil, {
        t(" lang=\""),
        c(1, {
          i(1, "ts"),
          i(2, "js"),
        }),
        t("\""),
      }),
      t(""),
    }),
    t({ ">", "" }),
    i(3),
    t({ "", "</script>" }),
  }),
  s({
    trig = "template",
    name = "Template tag",
    dscr = "Insert a template html tag",
  }, {
    f(function()
      if isStringBeforeCursor("<") then
        return ""
      end
      return "<"
    end),
    t({ "template>", "" }),
    i(1),
    t({ "", "</template>" }),
  }),
  s({
    trig = "style",
    name = "Style tag",
    dscr = "Insert a style css tag",
  }, {
    f(function()
      if isStringBeforeCursor("<") then
        return ""
      end
      return "<"
    end),
    t("style"),
    c(1, {
      i(1, " scoped"),
      t(""),
    }),
    c(2, {
      t(""),
      sn(nil, {
        i(1, " lang=\""),
        c(2, {
          i(1, "css"),
          i(2, "scss"),
        }),
        t("\""),
      }),
    }),
    t({ ">", "" }),
    i(3),
    t({ "", "</style>" }),
  }),
  s({
    trig = "rview",
    name = "RouterView",
    dscr = "Insert a Router View HTML (Vue) tag",
  }, {
    t("<RouterView"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1),
        t("\""),
      }),
      t(""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1),
        t("\""),
      }),
      t(""),
    }),
    t({ ">", "\t" }),
    i(3),
    t({ "", "</RouterView>" }),
  }),
  s({
    trig = "rlink",
    name = "RouterLink",
    dscr = "Insert a Router Link HTML (Vue) tag",
  }, {
    t("<RouterLink"),
    c(1, {
      sn(nil, {
        t(" id=\""),
        i(1),
        t("\""),
      }),
      t(""),
    }),
    c(2, {
      sn(nil, {
        t(" class=\""),
        i(1),
        t("\""),
      }),
      t(""),
    }),
    t(" to=\""),
    c(3, {
      sn(nil, {
        t("{ name: \""),
        i(1, "Home"),
        t("\" }"),
      }),
      i(1, "/"),
    }),
    t({ "\">", "\t" }),
    i(4),
    t({ "", "</RouterLink>" }),
  }),
}, {
  s({
    trig = "v-for=",
    name = "v-for loop",
    dscr = "Insert a vue v-for",
  }, {
    t("v-for=\""),
    i(1, "item"),
    t(" in "),
    i(2, "items"),
    t("\""),
    t(" :key=\""),
    f(function(args)
      return args[1][1] .. "."
    end, { 1 }),
    i(3, "id"),
    t("\""),
  }),
}
