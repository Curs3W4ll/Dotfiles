local function parseFormatters()
  local obj = {}

  for ft, formatters in pairs(require("plugins.mason-tools").formatter.listFormattersByFt()) do
    obj[ft] = {}
    for _, formatter in ipairs(formatters) do
      table.insert(obj[ft], require("formatter.filetypes." .. ft)[formatter])
    end
  end

  return obj
end

return function()
  require("formatter").setup({
    filetype = parseFormatters(),
  })
end
