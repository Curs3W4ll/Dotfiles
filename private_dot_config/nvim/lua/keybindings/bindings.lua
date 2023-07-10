local wk = require("which-key")
local map = require("utils").map

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
for i = 1, #escapeKeys do
    map("i", escapeKeys[i], "<ESC>")
end

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
        -- ===      Configuration       ===
        -- ================================
        ["<leader><C-r>"] = { function()
            require("utils").reloadConfiguration()
        end, "Reload neovim configuration", nowait = true },
        ["<leader><C-e>"] = { "<Cmd>edit $MYVIMRC<CR>", "Edit neovim configuration", nowait = true }, -- TODO upgrade this binding, currently just open a the init.lua file, but would be better to also change the root and open neo-tree
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
