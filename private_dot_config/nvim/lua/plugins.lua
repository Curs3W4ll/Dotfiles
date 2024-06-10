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
    mason,
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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- Markdown incode markup
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      -- Git modifications signs
      {
        "lewis6991/gitsigns.nvim",
        config = require("plugins.gitsigns"),
      },
    },
    config = require("plugins.scrollbar"),
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
        ft = { "gitcommit", "neo-tree-popup" },
        config = require("plugins.cmpgit"),
      },
      {
        "Dynge/gitmoji.nvim",
        ft = { "gitcommit", "neo-tree-popup" },
        config = require("plugins.gitmoji"),
      },
    },
    config = require("plugins.cmp"),
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
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
        "folke/lazydev.nvim",
        dependencies = {
          {
            "Bilal2453/luvit-meta",
            lazy = true,
          },
        },
        ft = "lua",
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      -- LSP UI
      {
        "nvimdev/lspsaga.nvim",
        event = "VeryLazy",
        config = require("plugins.lspsaga"),
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons",
        },
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
      "nvim-neotest/nvim-nio",
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
  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "olacin/telescope-gitmoji.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },
    },
    config = require("plugins.telescope"),
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
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = require("plugins.comment"),
  },
  -- Buffer deletion
  {
    "moll/vim-bbye",
  },
  -- Floating status lines
  {
    "b0o/incline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    config = require("plugins.incline"),
  },
  -- C++ online doc (cppreference.com)
  {
    "madskjeldgaard/cppman.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = require("plugins.cppman"),
  },
  -- References illumination
  {
    "RRethy/vim-illuminate",
    config = require("plugins.illuminate"),
  },
  -- Dims inactive portions of files
  {
    "folke/twilight.nvim",
  },
  -- Tree sitter (better tree parsing)
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = require("plugins.ts-autotag"),
      },
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = require("plugins.treesitter"),
  },
  -- Colors preview
  {
    "norcalli/nvim-colorizer.lua",
    config = require("plugins.colorizer"),
  },
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = require("plugins.autopairs"),
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
