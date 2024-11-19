local wk = require("which-key")
local neokit = require("neokit")

local function toggleMouseSupport()
  local notify = require("notify").notify

  if neokit.vim.getOption("mouse") == "" then
    notify("Mouse support has been enabled")
    neokit.vim.setOption("mouse", "nvi")
  else
    notify("Mouse support has been disabled")
    neokit.vim.setOption("mouse", "")
  end
end

wk.add({
  { "<leader><C-M>", toggleMouseSupport, mode = { "n", "v" }, desc = "Toggle mouse support" },
})
