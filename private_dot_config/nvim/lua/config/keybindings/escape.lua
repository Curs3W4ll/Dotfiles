local wk = require("which-key")
local neokit = require("neokit")

local escapeKeys = {
  "jk",
  "kj",
  "JK",
  "KJ",
  "jK",
  "Jk",
  "Kj",
  "kJ",
}
neokit.array.forEach(escapeKeys, function(key)
  wk.add({
    { key, "<Esc>", mode = "i" },
  })
end)
