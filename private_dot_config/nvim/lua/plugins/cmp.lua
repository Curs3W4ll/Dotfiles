return function()
  local has_word_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local ELLIPSIS_CHAR = "…"
  local MAX_LABEL_WIDTH = 60
  local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﴲ",
    Variable = "",
    Class = " ",
    Interface = "ﰮ",
    Module = "",
    Property = "襁",
    Unit = "",
    Value = "",
    Enum = "練",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "ﲀ",
    Struct = "ﳤ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  cmp.setup({
    -- Define window look
    window = {
      -- Adding borders around completion suggestions
      completion = cmp.config.window.bordered(),
      -- Adding borders around elements documentation
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      -- Use selected item
      -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
      -- Trigger completion window
      ["<C-Space>"] = cmp.mapping.complete(),
      -- Hide completion window
      ["<Esc>"] = cmp.mapping.abort(),
      -- Naviguate through items
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_word_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      -- Navigate backward through items
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
    }),
    -- Completion items format
    formatting = {
      format = function(entry, item)
        if item.kind == "TabNine" then
          item.kind = string.format("%s", entry.completion_item.data.completion_metadata.detail)
        elseif icons[item.kind] ~= nil then
          item.kind = string.format("%s [%s]", icons[item.kind], item.kind)
        else
          item.kind = string.format("[%s]", item.kind)
        end

        item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          cmp_tabnine = "[Tabnine]",
          path = "[Path]",
          cmp_path = "[Path]",
          luasnip = "[Snippet]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
        })[entry.source.name]

        local label = item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

        if truncated_label ~= label then
          item.abbr = truncated_label .. ELLIPSIS_CHAR
        end

        return item
      end,
    },
    -- Defining completion sources
    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "nvim_lsp" },
    }, {
      { name = "path" },
      { name = "cmp_tabnine" },
    }),
    -- Define which snippet to use
    snippet = {
      expand = function(args)
        if not luasnip then
          return
        end
        luasnip.lsp_expand(args.body)
      end,
    },
  })

  -- Configuration for vim search
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  -- Configuration for vim commands
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
  -- Configuration for git commits
  cmp.setup.filetype({ "gitcommit", "octo", "neo-tree-popup" }, {
    sources = cmp.config.sources({
      { name = "git" },
      { name = "gitmoji" },
    }, {
      { name = "buffer" },
    }),
  })
end
