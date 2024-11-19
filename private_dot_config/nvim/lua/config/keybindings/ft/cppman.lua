return {
  setup = function(bufnbr)
    if package.loaded["which-key"] then
      local wk = require("which-key")

      wk.add({
        buffer = bufnbr,
        { "<Enter>", proxy = "K", desc = "Search CPPMan for word under cursor", noremap = false },
        { "<BackSpace>", proxy = "<C-T>", desc = "Go back to previous CPPMan page", noremap = false },
      })
    end
  end,
}
