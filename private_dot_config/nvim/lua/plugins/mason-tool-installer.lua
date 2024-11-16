return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "Curs3W4ll/NeoKit",
  },
  lazy = true,
  opts = function()
    local mason_tools = require("config.mason-tools")

    return {
      -- Ensure that wanted Mason tools are installed
      ensure_installed = mason_tools.list(),
      -- Automatically update Mason tools
      auto_update = true,
    }
  end,
}
