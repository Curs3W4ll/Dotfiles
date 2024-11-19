return {
  setup = function(bufnbr)
    if package.loaded["which-key"] then
      local wk = require("which-key")

      wk.add({
        buffer = bufnbr,
        { "<leader>m", group = "Markdown preview" },
        { "<leader>mo", "<cmd>MarkdownPreview<cr>", desc = "Open markdown preview window" },
        { "<leader>mc", "<cmd>MarkdownPreviewStop<cr>", desc = "Close markdown preview window" },
      })
    end
  end,
}
