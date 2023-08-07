-- Setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local mason = {
    "williamboman/mason.nvim",
    config = require("plugins.mason"),
}
local mason_tools_installer = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        mason
    },
    config = require("plugins.mason-tool-installer"),
}

-- Plugins config
require("lazy").setup({
    -- Colorscheme
    {
        "folke/tokyonight.nvim",
        config = require("plugins.tokyonight"),
    },
    -- Shortcut keys displayer
    {
        "folke/which-key.nvim",
        config = require("plugins.which-key"),
    },
    -- Bottom infos in line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("plugins.lualine"),
    },
    -- Getting start up times informations
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    -- Finding todos markers
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = require("plugins.todo-comments"),
    },
    -- New window type like quickfix or telescope
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("plugins.trouble"),
    },
    -- Session saving
    {
        "folke/persistence.nvim",
        -- Only start session saving when a file is opened
        event = "BufReadPre",
        config = require("plugins.persistence"),
    },
    -- Markdown previewer
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        config = require("plugins.peek"),
    },
    -- Better searching
    {
        "kevinhwang91/nvim-hlslens",
        config = require("plugins.hlslens"),
    },
    -- Scrollbar
    {
        "petertriho/nvim-scrollbar",
        -- dependencies = {
        --     "kevinhwang91/nvim-hlslens",
        -- },
        config = require("plugins.scrollbar"),
    },
    -- Git modifications signs
    {
        "lewis6991/gitsigns.nvim",
        config = require("plugins.gitsigns"),
    },
    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            {
                "tzachar/cmp-tabnine",
                build = "./install.sh",
                config = require("plugins.cmp-tabnine"),
            },
            {
                "petertriho/cmp-git",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                },
                config = require("plugins.cmpgit"),
            },
        },
        config = require("plugins.cmp"),
    },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "1.*",
        build = "make install_jsregexp",
    },
    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "RishabhRD/popfix",
            "RishabhRD/nvim-lsputils",
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = {
                    mason_tools_installer,
                },
                config = require("plugins.mason-lspconfig"),
            },
            -- LSP overlay for nvim plugins
            {
                "folke/neodev.nvim",
                config = require("plugins.neodev"),
            },
        },
        config = require("plugins.lspconfig"),
    },
    -- Linter
    {
        "mfussenegger/nvim-lint",
        dependencies = {
            mason_tools_installer,
        },
        config = require("plugins.lint"),
    },
    -- Fomatter
    {
        "mhartington/formatter.nvim",
        dependencies = {
            mason_tools_installer,
        },
        config = require("plugins.formatter"),
    },
    -- DAP
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            {
                "mfussenegger/nvim-dap",
                dependencies = {
                    mason_tools_installer,
                },
                config = require("plugins.dap"),
            },
        },
        config = require("plugins.dap-ui"),
    },
    -- Greater dashboard
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("plugins.dashboard"),
    },
    -- Better quickfix windows.
    {
        "kevinhwang91/nvim-bqf",
    },
    -- Tree (files explorer)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = require("plugins.neo-tree"),
    },
    -- Buffers line
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("plugins.bufferline"),
    },
    -- Commenter
    {
        "terrortylor/nvim-comment",
        config = require("plugins.comment"),
    },
    -- Buffer deletion
    {
        "moll/vim-bbye",
    },
    -- Utilities
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
    },
    {
        "Curs3W4ll/NeoKit",
        lazy = true,
    },
}, {
    install = {
        -- Setup colorscheme before setting up plugins (set colorscheme for lazy popup at startup)
        colorscheme = { "tokyonight" },
    },
    -- Updates checker
    checker = {
        -- Enable the update checker
        enabled = true,
        -- Disable notifications in console when update are availables
        notify = false,
        -- Check for updates every 24 hours
        frequency = 86400,
    },
    ui = {
        -- Use rounded border for Lazy UI window
        border = "rounded",
    },
})
