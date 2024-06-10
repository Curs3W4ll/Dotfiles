return {
  markdown = function()
    local wk = require("which-key")

    wk.register({
      m = {
        name = "Markdown preview",
        ["o"] = { ":MarkdownPreview<CR>", "Open md preview window" },
        ["c"] = { ":MarkdownPreviewStop<CR>", "Close md preview window" },
      },
    }, {
      mode = "n",
      prefix = "<leader>",
    })
  end,
}
