return {
  "tzachar/cmp-tabnine",
  build = "./install.sh",
  lazy = true,
  opts = {
    -- Maximum buffer lines to pass to tabnine
    max_lines = 5000,
    -- Showing prediction percentage strength
    show_prediction_strength = true,
  },
}
