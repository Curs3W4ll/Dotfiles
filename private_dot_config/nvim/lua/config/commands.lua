local M = {
  filetypeDetectGroup = vim.api.nvim_create_augroup("filetypeDetect", { clear = true }),
  yankGroup = vim.api.nvim_create_augroup("yank", { clear = true }),
  prefetchGroup = vim.api.nvim_create_augroup("prefetch", { clear = true }),
  lintersGroup = vim.api.nvim_create_augroup("linters", { clear = true }),
  formattersGroup = vim.api.nvim_create_augroup("linters", { clear = true }),
}

-- =======================================
-- =============Auto commands=============
-- =======================================

-- Set filetype for arduino building popups
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  pattern = "*.ino*",
  command = "set filetype=arduinobuild",
  group = M.filetypeDetectGroup,
})
-- Set filetype for c files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h,*.c",
  command = "set filetype=c",
  group = M.filetypeDetectGroup,
})
-- Set filetype to Groovy for Jenkinsfile
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Jenkinsfile",
  command = "set filetype=groovy",
  group = M.filetypeDetectGroup,
})
-- Set indentation to 2 spaces for some files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "svg,javascript,typescript,typescriptreact,groovy,yaml,vue,css,json,vim,xml,html,lua",
  command = "set tabstop=2 shiftwidth=2",
  group = M.filetypeDetectGroup,
})
-- Leave some windows faster
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "qf,checkhealth,startuptime,help,gitsigns-blame",
  callback = function()
    require("neokit.vim").map({ "n", "v", "x" }, "q", ":q<CR>", { buffer = true })
  end,
  group = M.filetypeDetectGroup,
})
-- Disable folding in dashboard
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "dashboard",
  callback = function()
    require("neokit.vim").unmap("*", " ")
  end,
  group = M.filetypeDetectGroup,
})

-- Blink content when yanking
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = M.yankGroup,
})

-- Preload tabnine when opening a file
vim.api.nvim_create_autocmd({ "BufRead" }, {
  callback = function()
    require("cmp_tabnine"):prefetch(vim.fn.expand("%:p"))
  end,
  group = M.prefetchGroup,
})

-- Display notifications with mason tool installer plugin
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsStartingInstall",
  callback = function()
    vim.g.custom_masonStartedInstall = true
    require("notify").notify("Mason tools installer is starting...")
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsUpdateCompleted",
  callback = function()
    if vim.g.custom_masonStartedInstall == true then
      require("notify").notify("Mason tools installer has finished")
    end
  end,
})

-- Auto lint
vim.api.nvim_create_autocmd({ "BufRead", "BufWrite" }, {
  callback = function()
    require("lint").try_lint()
  end,
  group = M.lintersGroup,
})

-- Format on buffer save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  command = "silent! FormatWriteLock",
  group = M.formattersGroup,
})

-- Disable default LSP bindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.del("n", "K", { buffer = args.buf })
  end,
  group = M.lintersGroup,
})

-- =======================================
-- ============Custom commands============
-- =======================================

-- Make an alias between W and w
vim.api.nvim_create_user_command("W", "w", {})
-- Make an alias between Q and q
vim.api.nvim_create_user_command("Q", "q", {})
-- Make an alias between X and x
vim.api.nvim_create_user_command("X", "x", {})

return M
