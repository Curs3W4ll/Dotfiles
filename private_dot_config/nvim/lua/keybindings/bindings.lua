local wk = require("which-key")
local neokit = require("neokit")

-- ================================
-- ============Escaping============
-- ================================
local escapeKeys = {
    "jk",
    "kj",
    "JK",
    "KJ",
    "jK",
    "Jk",
    "Kj",
    "kJ",
}
neokit.array.forEach(escapeKeys, function(key)
    neokit.vim.map("i", key, "<ESC>")
end)

-- =====================
-- ===  Normal mode  ===
-- =====================
wk.register({
    {
        -- ================================
        -- ===     Window changement    ===
        -- ================================
        ["<C-j>"] = { "<C-w>j", "Move to below window" },
        ["<C-k>"] = { "<C-w>k", "Move to above window" },
        ["<C-h>"] = { "<C-w>h", "Move to left window" },
        ["<C-l>"] = { "<C-w>l", "Move to right window" },
        -- ================================
        -- ===          Saving          ===
        -- ================================
        ["<C-s>"] = { "<Cmd>w<CR>", "Save using common bindings" },
        -- ================================
        -- ===         Folding          ===
        -- ================================
        ["<Space>"] = { "za", "Toggle folding on current section", silent = true, nowait = true },
        ["<leader><Space>"] = { "zR", "Unfold all", silent = true, nowait = true },
        -- ================================
        -- ===          Search          ===
        -- ================================
        ["//"] = { "<Cmd>nohlsearch<CR>", "Disable search highlight" },
        -- ================================
        -- ===      Tools managers      ===
        -- ================================
        ["<leader><C-u>"] = { "<Cmd>Lazy update<CR><Cmd>MasonUpdate<CR><Cmd>MasonToolsUpdate<CR>", "Update plugins and tools", nowait = true },
        ["<leader><C-m>"] = { "<Cmd>Mason<CR>", "Open Mason (tools manager)", nowait = true },
        ["<leader><C-l>"] = { "<Cmd>Lazy<CR>", "Open Lazy (plugins manager)", nowait = true },
    },
}, { mode = "n" })
-- =====================
-- ===  Insert mode  ===
-- =====================
wk.register({
    {
        -- ================================
        -- ===          Saving          ===
        -- ================================
        ["<C-s>"] = { "<ESC><Cmd>w<CR>", "Save using common bindings" },
    },
}, { mode = "i" })
-- =====================
-- ===  Visual mode  ===
-- =====================
wk.register({
    {
        ["<leader>r"] = { "\"hy:%s/<C-r>h//gc<left><left><left>", "Replace selected", nowait = true },
    },
}, { mode = "v" })
