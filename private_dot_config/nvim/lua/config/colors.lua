return {
  diagnostics = {
    error = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }),
    warning = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }),
    info = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }),
    hint = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }),
  },
  light = "#c7f0e5",
  dark = "#3d403f",
  primary = "#5ee6c1",
  secondary = "#2f735f",
  indicator = "#e0af68",
}
