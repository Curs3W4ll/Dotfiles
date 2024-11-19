return {
  setup = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>s", group = "Sessions" },
      {
        "<leader>sd",
        function()
          require("persistence").load()
        end,
        desc = "Load last directory session",
      },
      {
        "<leader>sl",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Load last overall session",
      },
    })
  end,
}
