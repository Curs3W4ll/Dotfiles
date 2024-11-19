return {
  "b0o/incline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local devicons = require("nvim-web-devicons")
    local neokit = require("neokit")
    local usigns = require("config.signs")
    local ucolors = require("config.colors")
    local colors = {
      fg = ucolors.light,
      fgFocused = ucolors.light,
      bg = ucolors.secondary,
      bgFocused = ucolors.primary,
    }
    colors.fg = neokit.color.getContrastColor(colors.bg)
    colors.fgFocused = neokit.color.getContrastColor(colors.bgFocused) == "dark" and ucolors.dark or ucolors.light

    return {
      hide = {
        cursorline = true,
      },
      render = function(props)
        local bufName = vim.api.nvim_buf_get_name(props.buf)
        if bufName == "" then
          return {}
        end
        local isBufFocused = vim.api.nvim_get_current_buf() == props.buf
        local isBufModified = vim.api.nvim_get_option_value("modified", { buf = props.buf })
        local bufFiletype = vim.api.nvim_get_option_value("filetype", { buf = props.buf })
        local result = {}

        result.fg = isBufFocused and colors.fgFocused or colors.fg
        result.bg = isBufFocused and colors.bgFocused or colors.bg
        result.name = bufName == "" and "[No name]" or bufName
        result.icon, result.iconColor = devicons.get_icon_color(bufName)
        if not result.icon or result.icon == "" then
          local iconName
          if bufFiletype ~= "" then
            iconName = devicons.get_icon_name_by_filetype(bufFiletype)
          end
          if iconName and iconName ~= "" then
            result.icon, result.iconColor = devicons.get_icon_color(iconName)
          end
          if not result.icon or result.icon == "" then
            result.icon = "*"
          end
        end

        local hasError = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity.ERROR }) > 0
        local hasWarning = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity.WARN }) > 0
        local hasInfo = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity.INFO }) > 0
        local hasHint = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity.HINT }) > 0

        local ret = {
          {
            " ",
            result.icon,
            " ",
            guifg = isBufFocused and result.iconColor or nil,
          },
          {
            " ",
            neokit.fs.shortenPath(bufName, {
              len = 4,
              tail = 2,
              maxLength = vim.api.nvim_win_get_width(props.win) / 2,
              relative = true,
            }),
            " ",
            gui = isBufModified and "bold,italic" or nil,
            guifg = isBufFocused and result.fgFocused or result.fg,
            guibg = isBufFocused and result.bgFocused or result.bg,
          },
          guibg = "#" .. string.format("%x", vim.api.nvim_get_hl(0, { name = "lualine_b_normal" }).bg),
        }
        if isBufModified then
          table.insert(ret, {
            " ",
            usigns.ball,
            guifg = ucolors.indicator,
          })
        end
        if hasError or hasWarning or hasInfo or hasHint then
          table.insert(ret, {
            " ",
            guifg = ucolors.indicator,
          })
        end
        if hasError then
          table.insert(ret, {
            usigns.diagnostics.error,
            group = "DiagnosticError",
          })
        end
        if hasWarning then
          table.insert(ret, {
            usigns.diagnostics.warning,
            group = "DiagnosticWarn",
          })
        end
        if hasInfo then
          table.insert(ret, {
            usigns.diagnostics.info,
            group = "DiagnosticInfo",
          })
        end
        if hasHint then
          table.insert(ret, {
            usigns.diagnostics.hint,
            group = "DiagnosticHint",
          })
        end
        if hasError or hasWarning or hasInfo or hasHint then
          table.insert(ret, {
            " ",
            guifg = ucolors.indicator,
          })
        end
        return ret
      end,
      window = {
        -- Text position
        placement = {
          vertical = "top",
          horizontal = "right",
        },
        -- Text margin
        margin = {
          vertical = 0,
          horizontal = 1,
        },
        -- Remove text padding
        padding = 0,
        winhighlight = {
          Normal = "Normal",
        },
      },
    }
  end,
}
