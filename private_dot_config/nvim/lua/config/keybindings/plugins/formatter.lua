local function formatIfToolInstalled()
  local currentFt = vim.api.nvim_buf_get_option(0, "filetype")

  if require("neokit.array").contains(require("config.mason-tools").formatter.listFormattersFt(), currentFt) then
    vim.cmd("FormatLock")
  else
    require("notify").notify("No installed formatter for filetype '" .. currentFt .. "'")
  end
end
local wk = require("which-key")

return {
  setup = function()
    wk.add({
      { "<C-F>", formatIfToolInstalled, desc = "Format code" },
    })
  end,
}
