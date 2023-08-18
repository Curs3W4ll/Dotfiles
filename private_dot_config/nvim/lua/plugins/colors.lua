return {
    diagnostics = {
        error = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }),
        warning = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }),
        info = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }),
        hint = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }),
    },
    light = "#c7f0e5",
    dark = "#6a6e6d",
    primary = "#3d9980",
    secondary = "#2c5c4e",
    indicator = "#e0af68",
}
