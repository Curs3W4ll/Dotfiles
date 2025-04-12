return {
  setup = function()
    local wk = require("which-key")

    local function close_all()
      for _, item in ipairs(require("bufferline").get_elements().elements) do
        vim.schedule(function()
          vim.cmd("bd " .. item.id)
        end)
      end
    end

    wk.add({
      { "<leader>b", group = "Buffers" },
      { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Go to next buffer" },
      { "<leader>bN", "<cmd>BufferLineCyclePrev<cr>", desc = "Go to previous buffer" },
      {
        "<leader>0",
        function()
          require("bufferline").go_to(1, true)
        end,
        desc = "Go to first buffer",
      },
      {
        "<leader>$",
        function()
          require("bufferline").go_to(0, true)
        end,
        desc = "Go to last buffer",
      },
      { "<leader>b>", "<cmd>BufferLineMoveNext<cr>", desc = "Move current buffer right" },
      { "<leader>b<", "<cmd>BufferLineMovePrev<cr>", desc = "Move current buffer left" },
      { "<leader>be", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort buffers by extension" },
      { "<leader>bd", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort buffers by directory" },
      { "<leader>bc", group = "Delete buffer" },
      { "<leader>bcc", "<cmd>Bdelete<cr>", desc = "Close current buffer" },
      { "<leader>bcp", "<cmd>BufferLinePickClose<cr>", desc = "Pick buffer to close" },
      { "<leader>bc<", "<cmd>BufferLineCloseLeft<cr>", desc = "Close left buffer" },
      { "<leader>bc>", "<cmd>BufferLineCloseRight<cr>", desc = "Close right buffer" },
      { "<leader>bco", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
      { "<leader>bca", close_all, desc = "Close all buffers" },
      { "<leader>bq", "<cmd>Bdelete<cr>", desc = "Close current buffer" },
      -- Shortands
      { "<leader>k", "<cmd>BufferLineCycleNext<cr>", desc = "Go to next buffer" },
      { "<leader>j", "<cmd>BufferLineCyclePrev<cr>", desc = "Go to previous buffer" },
      { "<leader>>", "<cmd>BufferLineMoveNext<cr>", desc = "Move current buffer right" },
      { "<leader><", "<cmd>BufferLineMovePrev<cr>", desc = "Move current buffer left" },
      { "<leader>bQ", close_all, desc = "Close all buffers" },
    })
  end,
}
