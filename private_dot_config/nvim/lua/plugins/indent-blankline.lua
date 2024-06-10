return function()
  require("ibl").setup({
    exclude = {
      filetypes = {
        "dashboard",
      },
    },
  })
end
