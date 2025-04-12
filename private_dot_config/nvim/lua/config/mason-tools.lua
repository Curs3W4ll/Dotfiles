local neokit = require("neokit")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

local M = {
  lsp = {
    -- Ansible
    --{ name = "ansiblels" }, -- TODO: Configure
    -- Arduino
    --{ name = "arduino_language_server" }, -- TODO: Configure
    -- ASM
    --{ name = "asm_lsp" }, -- TODO: Configure
    -- Awk
    --{ name = "awk-language-server" }, -- TODO: Configure
    -- Azure
    --{ name = "azure-pipelines-language-server" }, -- TODO: Configure
    --{ name = "bicep-lsp" }, -- TODO: Configure
    -- Bash / ZSH
    --{ name = "bashls" }, -- TODO: Configure
    -- C / C++
    {
      name = "clangd",
    },
    -- C# / .NET
    --{ name = "csharp_ls" }, -- TODO: Configure
    --{ name = "omnisharp" }, -- TODO: Configure
    --{ name = "omnisharp-mono" }, -- TODO: Configure
    -- CMake
    --{ name = "cmake" }, -- TODO: Configure
    --{ name = "neocmake" }, -- TODO: Configure
    -- CSS
    --{ name = "cssls" }, -- TODO: Configure
    --{ name = "cssmodules_ls" }, -- TODO: Configure
    --{ name = "unocss" }, -- TODO: Configure
    {
      name = "tailwindcss-language-server",
      lsp_name = "tailwindcss",
      additional_settings = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "css" },
        root_dir = require("lspconfig").util.root_pattern("tailwind.config.*"),
      },
    }, -- TODO: Configure
    -- Deno
    --{ name = "denols" }, -- TODO: Configure
    -- Docker
    --{ name = "dockerls" }, -- TODO: Configure
    --{ name = "docker_compose_language_service" }, -- TODO: Configure
    -- Go
    --{ name = "golangci-lint-langserver" }, -- TODO: Configure
    --{ name = "gopls" }, -- TODO: Configure
    -- HTML
    --{ name = "html" }, -- TODO: Configure
    -- Java
    --{ name = "groovyls" }, -- TODO: Configure
    --{ name = "java-language-server" }, -- TODO: Configure
    -- Javascript / Typescript
    --{ name = "angular-language-server" }, -- TODO: Configure
    { name = "eslint" }, -- TODO: Configure
    --{ name = "quick_lint_js" }, -- TODO: Configure
    --{ name = "rome" }, -- TODO: Configure
    {
      name = "ts_ls",
      -- NOTE: For vue support, comes from https://github.com/williamboman/mason-lspconfig.nvim/issues/371#issuecomment-2188015156
      additional_settings = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = volar_path,
              languages = { "vue" },
            },
          },
        },
      },
    }, -- TODO: Configure
    --{ name = "vtsls" }, -- TODO: Configure
    -- JSON
    --{ name = "jsonls" }, -- TODO: Configure
    -- JQ
    --{ name = "jq-lsp" }, -- TODO: Configure
    -- Lua
    {
      name = "lua-language-server",
      lsp_name = "lua_ls",
      additional_settings = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "s", "i", "sn", "t", "fmt" },
            },
          },
        },
      },
    },
    -- Markdown
    --{ name = "marksman" }, -- TODO: Configure
    --{ name = "prosemd_lsp" }, -- TODO: Configure
    --{ name = "remark_ls" }, -- TODO: Configure
    --{ name = "zk" }, -- TODO: Configure
    -- Nginx
    --{ name = "nginx-language-server" }, -- TODO: Configure
    -- Perl
    --{ name = "perlnavigator" }, -- TODO: Configure
    -- PHP
    --{ name = "intelephense" }, -- TODO: Configure
    --{ name = "phpactor" }, -- TODO: Configure
    --{ name = "psalm" }, -- TODO: Configure
    -- PowerShell
    --{ name = "powershell_es" }, -- TODO: Configure
    -- Python
    --{ name = "jedi_language_server" }, -- TODO: Configure
    --{ name = "pylyzer" }, -- TODO: Configure
    --{ name = "pyre" }, -- TODO: Configure
    { name = "pyright" }, -- TODO: Configure
    { name = "python-lsp-server", lsp_name = "pylsp" }, -- TODO: Configure
    --{ name = "ruff_lsp" }, -- TODO: Configure
    --{ name = "sourcery" }, -- TODO: Configure
    -- Ruby
    --{ name = "ruby_ls" }, -- TODO: Configure
    --{ name = "solargraph" }, -- TODO: Configure
    --{ name = "sorbet" }, -- TODO: Configure
    --{ name = "standardrb" }, -- TODO: Configure
    -- Rust
    --{ name = "rust_analyzer" }, -- TODO: Configure
    -- SQL
    --{ name = "sqlls" }, -- TODO: Configure
    -- Terraform
    --{ name = "terraformls" }, -- TODO: Configure
    --{ name = "tflint" }, -- TODO: Configure
    -- Vim
    --{ name = "vimls" }, -- TODO: Configure
    -- VueJS
    {
      name = "volar",
      -- NOTE: For vue support, comes from https://github.com/williamboman/mason-lspconfig.nvim/issues/371#issuecomment-2188015156
      additional_settings = {
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },
    }, -- TODO: Configure
    -- XML
    --{ name = "lemminx" }, -- TODO: Configure
    -- YAML
    --{ name = "yamlls" }, -- TODO: Configure
    -- Misc
    -- {
    --     name = "grammarly-languageserver",
    --     lsp_name = "grammarly",
    -- },
  },
  dap = {
    -- Bash / Zsh
    --{ name = "bash-debug-adapter" }, -- TODO: Configure
    -- C / C++
    {
      name = "cpptools",
      adapter = {
        name = "cppdbg",
        config = {
          id = "cppdbg",
          type = "executable",
          command = "OpenDebugAD7",
        },
      },
      configs = {
        {
          config_ft = { "cpp", "c" },
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input({
              prompt = "Path to executable: ",
              text = vim.fn.getcwd() .. "/",
              completion = "file",
            })
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
      },
    },
    -- C# / .NET
    --{ name = "netcorebg" }, -- TODO: Configure
    -- Go
    --{ name = "delve" }, -- TODO: Configure
    --{ name = "go-debug-adapter" }, -- TODO: Configure
    -- Java
    --{ name = "java-debug-adapter" }, -- TODO: Configure
    --{ name = "java-language-server" }, -- TODO: Configure
    --{ name = "java-test" }, -- TODO: Configure
    -- Javascript / Typescript
    --{ name = "chrome-debug-adapter" }, -- TODO: Configure
    --{ name = "js-debug-adapter" }, -- TODO: Configure
    --{ name = "node-debug2-adapter" }, -- TODO: Configure
    -- PHP
    --{ name = "php-debug-adapter" }, -- TODO: Configure
    -- Python
    --{ name = "debugpy" }, -- TODO: Configure
  },
  linter = {
    -- Ansible
    --{ name = "ansible-lint" }, -- TODO: Configure
    -- Bash / Zsh
    --{ name = "shellcheck" }, -- TODO: Configure
    --{ name = "shellharden" }, -- TODO: Configure
    -- C / C++
    --{ name = "cpplint" }, -- TODO: Configure
    -- Cmake
    --{ name = "cmakelang" }, -- TODO: Configure
    --{ name = "cmakelint" }, -- TODO: Configure
    -- Docker
    --{ name = "hadolint" }, -- TODO: Configure
    -- Github actions
    --{ name = "actionlint" }, -- TODO: Configure
    -- Go
    --{ name = "golangci-lint" }, -- TODO: Configure
    --{ name = "gospel" }, -- TODO: Configure
    --{ name = "revive" }, -- TODO: Configure
    --{ name = "staticcheck" }, -- TODO: Configure
    -- HTML
    --{ name = "erb-lint" }, -- TODO: Configure
    -- Javascript / Typescript
    --{ name = "eslint_d" }, -- TODO: Configure
    --{ name = "quick-lint-js" }, -- TODO: Configure
    --{ name = "rome" }, -- TODO: Configure
    --{ name = "standardjs" }, -- TODO: Configure
    --{ name = "xo" }, -- TODO: Configure
    -- Jinja
    --{ name = "curlylint" }, -- TODO: Configure
    --{ name = "djlint" }, -- TODO: Configure
    -- JSON
    --{ name = "jsonlint" }, -- TODO: Configure
    -- Lua
    -- NOTE: Not using them as the lsp is enough for now
    -- {
    --     name = "luacheck",
    --     ft = { "lua" },
    -- },
    -- {
    --     name = "selene",
    --     ft = { "lua" },
    -- },
    -- Markdown
    --{ name = "alex" }, -- TODO: Configure
    --{ name = "markdownlint" }, -- TODO: Configure
    -- PHP
    --{ name = "phpcs" }, -- TODO: Configure
    --{ name = "phpmd" }, -- TODO: Configure
    --{ name = "phpstan" }, -- TODO: Configure
    -- Python
    --{ name = "mypy" }, -- TODO: Configure
    --{ name = "pydocstyle" }, -- TODO: Configure
    --{ name = "pyflakes" }, -- TODO: Configure
    --{ name = "pylama" }, -- TODO: Configure
    --{ name = "pylint" }, -- TODO: Configure
    --{ name = "pyre" }, -- TODO: Configure
    --{ name = "ruff" }, -- TODO: Configure
    --{ name = "rstcheck" }, -- TODO: Configure
    --{ name = "vulture" }, -- TODO: Configure
    -- Ruby
    --{ name = "standardrb" }, -- TODO: Configure
    --{ name = "rubocop" }, -- TODO: Configure
    -- SQL
    --{ name = "sqlfluff" }, -- TODO: Configure
    -- Terraform
    --{ name = "tflint" }, -- TODO: Configure
    --{ name = "tfsec" }, -- TODO: Configure
    -- Vimscript
    --{ name = "vint" }, -- TODO: Configure
    -- YAML
    --{ name = "yamllint" }, -- TODO: Configure
    -- Misc
    {
      -- Writing
      name = "codespell",
      ft = { "markdown", "text" },
    },
    --{ name = "editorconfig-checker" }, -- .editorconfig -- TODO: Configure
    {
      -- Writing
      name = "proselint",
      ft = { "markdown", "text" },
    },
    --{ name = "sonarlint-language-server" }, -- Sonarlint (from Sonarqube) -- TODO: Configure
    {
      -- Writing
      name = "vale",
      ft = { "markdown", "text" },
    },
  },
  formatter = {
    -- Bash / Zsh
    --{ name = "beautysh" }, -- TODO: Configure
    --{ name = "shellharden" }, -- TODO: Configure
    --{ name = "shfmt" }, -- TODO: Configure
    -- C / C++
    {
      name = "clang-format",
      formatter_name = "clangformat",
      ft = { "c", "cpp" },
    },
    -- C# / .NET
    --{ name = "csharpier" }, -- TODO: Configure
    -- Cmake
    --{ name = "cmakelang" }, -- TODO: Configure
    --{ name = "gersemi" }, -- TODO: Configure
    -- Go
    --{ name = "gofumpt" }, -- TODO: Configure
    --{ name = "goimports" }, -- TODO: Configure
    --{ name = "goimports-reviser" }, -- TODO: Configure
    --{ name = "golines" }, -- TODO: Configure
    --{ name = "gomodifytags" }, -- TODO: Configure
    --{ name = "gotests" }, -- TODO: Configure
    -- HTML
    --{ name = "htmlbeautifier" }, -- TODO: Configure
    -- Java
    --{ name = "google-java-format" }, -- TODO: Configure
    -- Javascript / Typescript
    --{ name = "rustywind" }, -- TODO: Configure
    --{ name = "standardjs" }, -- TODO: Configure
    -- Jinja
    --{ name = "djlint" }, -- TODO: Configure
    -- JSON
    --{ name = "fixjson" }, -- TODO: Configure
    --{ name = "jq" }, -- TODO: Configure
    -- Lua
    {
      name = "stylua",
      ft = "lua",
    },
    -- Markdown
    --{ name = "cbfmt" }, -- TODO: Configure
    --{ name = "markdown-toc" }, -- TODO: Configure
    --{ name = "markdownlint" }, -- TODO: Configure
    --{ name = "remark-cli" }, -- TODO: Configure
    -- PHP
    --{ name = "pint" }, -- TODO: Configure
    --{ name = "php-cs-fixer" }, -- TODO: Configure
    --{ name = "phpcbf" }, -- TODO: Configure
    -- Python
    --{ name = "autoflake" }, -- TODO: Configure
    --{ name = "autopep8" }, -- TODO: Configure
    --{ name = "black" }, -- TODO: Configure
    --{ name = "blackd-client" }, -- TODO: Configure
    --{ name = "blue" }, -- TODO: Configure
    --{ name = "docformatter" }, -- TODO: Configure
    --{ name = "isort" }, -- TODO: Configure
    --{ name = "pyink" }, -- TODO: Configure
    --{ name = "pyment" }, -- TODO: Configure
    --{ name = "reorder-python-imports" }, -- TODO: Configure
    --{ name = "usort" }, -- TODO: Configure
    --{ name = "yapf" }, -- TODO: Configure
    -- Ruby
    --{ name = "rubocop" }, -- TODO: Configure
    -- Rust
    --{ name = "rustfmt" }, -- TODO: Configure
    -- SQL
    --{ name = "sqlfmt" }, -- TODO: Configure
    --{ name = "sql-formatter" }, -- TODO: Configure
    -- XML
    --{ name = "xmlformatter" }, -- TODO: Configure
    -- YAML
    --{ name = "yamlfix" }, -- TODO: Configure
    --{ name = "yamlfmt" }, -- TODO: Configure
    -- Misc
    -- { name = "prettier" }, -- AngularJS, CSS, GraphQL, HTML, JSON, JSX, Javascript / Typescript, Markdown... -- TODO: Configure
    {
      name = "prettierd",
      ft = { "javascript", "typescript", "vue", "html", "css", "markdown", "json" },
    }, -- AngularJS, CSS, GraphQL, HTML, JSON, JSX, Javascript / Typescript, Markdown... -- TODO: Configure
  },
}

local function groupByFt(src_tbl)
  local obj = {}

  for _, elem in ipairs(src_tbl) do
    if elem.ft ~= nil then
      for _, ft in ipairs(type(elem.ft) == "table" and elem.ft or { elem.ft }) do
        if obj[ft] == nil then
          obj[ft] = {}
        end
        table.insert(obj[ft], elem)
      end
    end
  end

  return obj
end

function M.lsp.list()
  return neokit.array.mergeTables(M.lsp, "name")
end

function M.dap.list()
  return neokit.array.mergeTables(M.dap, "name")
end
function M.dap.listDapFt()
  local fts = {}
  local seen = {}

  for _, dap_entry in ipairs(M.dap) do
    if dap_entry.configs then
      for _, config in ipairs(dap_entry.configs) do
        if config.config_ft then
          for _, ft in ipairs(config.config_ft) do
            if not seen[ft] then
              table.insert(fts, ft)
              seen[ft] = true
            end
          end
        end
      end
    end
  end

  return fts
end

function M.linter.list()
  return neokit.array.mergeTables(M.linter, "name")
end
function M.linter.listLintersByFt()
  local list = groupByFt(M.linter)

  for i, elem in pairs(list) do
    list[i] = neokit.array.mergeTables(elem, { "linter_name", "name" })
  end

  return list
end
function M.linter.listLintersFt()
  local list = groupByFt(M.linter)
  local fts = {}

  for key, _ in pairs(list) do
    table.insert(fts, key)
  end

  return fts
end

function M.formatter.list()
  return neokit.array.mergeTables(M.formatter, "name")
end
function M.formatter.listFormattersByFt()
  local list = groupByFt(M.formatter)

  for key, elem in pairs(list) do
    list[key] = neokit.array.mergeTables(elem, { "formatter_name", "name" })
  end

  return list
end
function M.formatter.listFormattersFt()
  local list = groupByFt(M.formatter)
  local fts = {}

  for key, _ in pairs(list) do
    table.insert(fts, key)
  end

  return fts
end

function M.list()
  local list = {}

  list = neokit.array.concat(list, M.lsp.list())
  list = neokit.array.concat(list, M.dap.list())
  list = neokit.array.concat(list, M.linter.list())
  list = neokit.array.concat(list, M.formatter.list())

  return list
end

return M
