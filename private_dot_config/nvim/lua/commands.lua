-- =======================================
-- =============Auto commands=============
-- =======================================

local filetypeDetectGroup = vim.api.nvim_create_augroup("filetypeDetect", { clear = true })
-- Set filetype for arduino building popups
vim.api.nvim_create_autocmd(
    { "TermOpen", "TermEnter" },
    {
        pattern = "*.ino*",
        command = "set filetype=arduinobuild",
        group = filetypeDetectGroup,
    }
)
-- Set filetype for c files
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    {
        pattern = "*.h,*.c",
        command = "set filetype=c",
        group = filetypeDetectGroup,
    }
)
-- Set filetype to groovy for Jenkinsfile to enable coloration
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    {
        pattern = "Jenkinsfile",
        command = "set filetype=groovy",
        group = filetypeDetectGroup,
    }
)
-- Set indentation to 2 spaces for some files
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "svg,javascript,typescript,typescriptreact,groovy,yaml,vue,css,json,vim,xml",
        command = "setlocal tabstop=2 shiftwidth=2",
        group = filetypeDetectGroup,
    }
)
-- Leave some windows faster
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "qf,checkhealth,startuptime,help",
        command = "map q :q<CR>",
        group = filetypeDetectGroup,
    }
)
-- Disable folding in dashboard
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "dashboard",
        command = "lua require('utils').unmap('<Space>')",
        group = filetypeDetectGroup,
    }
)
-- Markdown preview bindings
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = "markdown",
        command = "lua require('keybindings.peek')()",
        group = filetypeDetectGroup,
    }
)

local yankGroup = vim.api.nvim_create_augroup("yank", { clear = true })
-- Blink content when yanking
vim.api.nvim_create_autocmd(
    { "TextYankPost" },
    {
        command = "silent! lua vim.highlight.on_yank()",
        group = yankGroup,
    }
)

local prefetchGroup = vim.api.nvim_create_augroup("prefetch", { clear = true})
-- Preload tabnine when opening a file
vim.api.nvim_create_autocmd(
    { "BufRead" },
    {
        group = prefetchGroup,
        callback = function()
            require("cmp_tabnine"):prefetch(vim.fn.expand("%:p"))
        end,
    }
)

-- Display notifications with mason tool installer plugin
vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        callback = function()
            vim.g.custom_masonStartedInstall = true
            require("notify").notify("Mason tools installer is starting...")
        end,
    }
)
vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        callback = function()
            if vim.g.custom_masonStartedInstall == true then
                require("notify").notify("Mason tools installer has finished")
            end
        end,
    }
)

-- Linters
vim.api.nvim_create_autocmd(
    { "BufRead", "BufWrite" },
    {
        command = "lua require('lint').try_lint()",
        group = filetypeDetectGroup,
    }
)
-- Format on buffer save
-- FIXME: Reactivate when bug fixed
-- vim.api.nvim_create_autocmd(
--     { "BufWritePost" },
--     {
--         command = "FormatWriteLock",
--     }
-- )

-- =======================================
-- ============Custom commands============
-- =======================================

-- Make an alias between W and w
vim.api.nvim_create_user_command("W", "w", {})
-- Make an alias between Q and q
vim.api.nvim_create_user_command("Q", "q", {})
