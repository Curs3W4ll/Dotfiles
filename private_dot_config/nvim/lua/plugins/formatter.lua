local function parseFormatters()
  local obj = {}

  for ft, formatters in pairs(require("config.mason-tools").formatter.listFormattersByFt()) do
    obj[ft] = {}
    for _, formatter in ipairs(formatters) do
      table.insert(obj[ft], require("formatter.filetypes." .. ft)[formatter])
    end
  end

  return obj
end

return {
  "mhartington/formatter.nvim",
  dependencies = {
    "Curs3W4ll/NeoKit",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  ft = function()
    return require("config.mason-tools").formatter.listFormattersFt()
  end,
  opts = function()
    return {
      filetype = parseFormatters(),
    }
  end,
}
