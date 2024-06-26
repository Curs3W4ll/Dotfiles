-- =======================================
-- =============Auto commands=============
-- =======================================

local filetypeDetectGroup = vim.api.nvim_create_augroup("filetypeDetect", { clear = true })
-- Set filetype for arduino building popups
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  pattern = "*.ino*",
  command = "set filetype=arduinobuild",
  group = filetypeDetectGroup,
})
-- Set filetype for c files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h,*.c",
  command = "set filetype=c",
  group = filetypeDetectGroup,
})
-- Set filetype to groovy for Jenkinsfile to enable coloration
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Jenkinsfile",
  command = "set filetype=groovy",
  group = filetypeDetectGroup,
})
-- Set indentation to 2 spaces for some files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "svg,javascript,typescript,typescriptreact,groovy,yaml,vue,css,json,vim,xml,html,lua",
  command = "set tabstop=2 shiftwidth=2",
  group = filetypeDetectGroup,
})
-- Leave some windows faster
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "qf,checkhealth,startuptime,help",
  callback = function()
    require("neokit.vim").map("*", "q", ":q<CR>", { buffer = true })
  end,
  group = filetypeDetectGroup,
})
-- Disable folding in dashboard
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "dashboard",
  callback = function()
    require("neokit.vim").unmap("*", " ")
  end,
  group = filetypeDetectGroup,
})
-- Markdown files bindings
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function()
    require("keybindings.markdown-preview").markdown()
  end,
  group = filetypeDetectGroup,
})
-- C++ files bindings
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "cpp",
  callback = function()
    require("keybindings.cppman").cpp()
  end,
  group = filetypeDetectGroup,
})
-- CPPMan files bindings
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "cppman",
  callback = function()
    require("keybindings.cppman").cppman()
  end,
  group = filetypeDetectGroup,
})

local yankGroup = vim.api.nvim_create_augroup("yank", { clear = true })
-- Blink content when yanking
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = yankGroup,
})

local prefetchGroup = vim.api.nvim_create_augroup("prefetch", { clear = true })
-- Preload tabnine when opening a file
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = prefetchGroup,
  callback = function()
    require("cmp_tabnine"):prefetch(vim.fn.expand("%:p"))
  end,
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

-- Linters
local lintersGroup = vim.api.nvim_create_augroup("linters", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufWrite" }, {
  callback = function()
    require("lint").try_lint()
  end,
  group = lintersGroup,
})
-- Formatters
local formattersGroup = vim.api.nvim_create_augroup("linters", { clear = true })
-- Format on buffer save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  command = "FormatWriteLock",
  group = formattersGroup,
})

-- =======================================
-- ============Custom commands============
-- =======================================

-- Make an alias between W and w
vim.api.nvim_create_user_command("W", "w", {})
-- Make an alias between Q and q
vim.api.nvim_create_user_command("Q", "q", {})
