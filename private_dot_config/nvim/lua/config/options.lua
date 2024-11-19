local neokit = require("neokit")

local function parseOptions(options)
  neokit.table.forEach(options, function(option, value)
    neokit.vim.setOption(option, value)
  end)
end

local undodir = "/tmp/nvim_undodir"
neokit.fs.ensureDirectory(undodir)

local options = {
  fixendofline = false, -- Disable adding new line at end of files when saving
  linebreak = true, -- Split too long line smartly
  wildignorecase = true, -- Make files auto-completion case insensitive
  wildignore = neokit.vim.getOption("wildignore") .. "*.a,*.o,*.gcno,*.gcda", -- Ignore patterns while auto-completing files
  ignorecase = true, -- Make the search case insensitive
  clipboard = "unnamedplus", -- Using '+' register for yank, delete... operations
  cpoptions = "B", -- Disable vi-compatible mode
  number = true, -- Display current line number
  relativenumber = true, -- Display line numbers relatively from current
  mouse = "", -- Disable mouse support
  tabstop = 4, -- Number of spaces used for an indentation
  shiftwidth = 4, -- Number of spaces used when indenting with auto-indent, < and >
  expandtab = true, -- Adding only neaded spaces when inserting a tabulation
  foldmethod = "expr", -- Folding according to expressions
  foldexpr = "nvim_treesitter#foldexpr()", -- Use treesitter for folding
  foldnestmax = 10, -- Limit nested folds to 10
  foldenable = true, -- Allow toggling the fold
  foldlevel = 99, -- Close folds with a higher level than 2
  undofile = true, -- Enable storing undo history in a file
  undodir = undodir, -- Specifying undo directory
  cursorline = true, -- Highlight current line
  showbreak = "↪", -- Custom break symbol
  pumheight = 20, -- Maximum elements in popups
  smartindent = true, -- Automatically indent with patterns that define scopes
  shellcmdflag = "-ic", -- Make vim able to find my aliases
  swapfile = false, -- Disable swapfiles
}
parseOptions(options)

vim.cmd("syntax on")
