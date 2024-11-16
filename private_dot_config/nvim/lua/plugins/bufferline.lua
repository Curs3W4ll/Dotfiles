return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local signs = require("config.signs")

    return {
      options = {
        -- Selected buffer style
        indicator = {
          style = "underline",
        },
        -- Use to retrieve diagnostics
        diagnostics = "nvim_lsp",
        -- Do not update diagnostics while in insert mode
        diagnostics_update_in_insert = false,
        -- Text to translate diagnostics informations
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
          local diagnostics = {
            error = 0,
            warning = 0,
            info = 0,
            hint = 0,
          }
          local s = ""

          for e, n in pairs(diagnostics_dict) do
            diagnostics[e] = diagnostics[e] + n
          end

          if diagnostics.error ~= 0 then
            s = s .. diagnostics.error .. signs.diagnostics.error .. " "
          end
          if diagnostics.warning ~= 0 then
            s = s .. diagnostics.warning .. signs.diagnostics.warning .. " "
          end
          if diagnostics.info ~= 0 then
            s = s .. diagnostics.info .. signs.diagnostics.info .. " "
          end
          if diagnostics.hint ~= 0 then
            s = s .. diagnostics.hint .. signs.diagnostics.hint .. " "
          end

          return s
        end,
        offsets = {
          -- Set an offset so it ignore the neo-tree window
          {
            filetype = "neo-tree",
            text = "File Explorer",
            fg = "#ff0000",
            text_align = "center",
            separator = true,
          },
        },
        -- Style of the separators
        separator_style = "slant",
      },
    }
  end,
}
