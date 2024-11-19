return {
  "norcalli/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("colorizer").setup({ "*", css = {
      css = true,
    }, html = { css = true }, vue = { css = true } }, {
      RRGGBBAA = true,
    })
  end,
}
