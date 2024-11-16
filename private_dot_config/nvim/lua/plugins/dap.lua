local function parseAdapters()
  local adapters = {}
  for _, dap in ipairs(require("config.mason-tools").dap) do
    adapters[dap.adapter.name] = dap.adapter.config
  end

  return adapters
end
local function parseConfigurations()
  local configurations = {}

  for _, dap in ipairs(require("config.mason-tools").dap) do
    for _, config in ipairs(dap.configs) do
      for _, ft in ipairs(type(config.config_ft) == "table" and config.config_ft or { config.config_ft }) do
        if configurations[ft] == nil then
          configurations[ft] = {}
        end
        table.insert(configurations[ft], config)
      end
    end
  end

  return configurations
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "Curs3W4ll/NeoKit",
  },
  ft = function()
    return require("config.mason-tools").dap.listDapFt()
  end,
  config = function()
    local dap = require("dap")

    dap.adapters = parseAdapters()
    dap.configurations = parseConfigurations()
  end,
}
