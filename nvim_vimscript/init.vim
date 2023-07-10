set nofixendofline                              " Disable adding new line and end of oppened files
set linebreak                                   " Split too long line smart

" Auto-completion
set wildignorecase                              " Make filenames autocompletion case-insensitive
set wildignore+=*.a,*.o,*.gcno,*.gcda           " Exclude tmp fils from autocompletion
set t_Co=256

set autowriteall                                " Autowrite when replace in multiple buffers

set ignorecase                                  " Make search case insensitive

set termguicolors                               " Set colorscheme

set clipboard=unnamedplus                       " Copy and paste between vim and others
set nocp

set number                                      " Display lines number
set nu rnu                                      " Make lines number display relative

set mouse=""                                    " Disable mouse support

augroup filetypedetect
  autocmd!

  " Detect ino build buffer
  autocmd TermOpen,TermEnter *.ino* set filetype=arduinobuild

  " Separate c file as a new type
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c

  " Separate qml files as a new type
  autocmd BufRead,BufNewFile *.qml set filetype=qml

  " Jenkinsfile highlighting
  au BufNewFile,BufRead Jenkinsfile setf groovy
augroup END

" Make maj W works as w
command -nargs=+ W :w "<args>"
" Make maj Q works as q
command -nargs=+ Q :q "<args>"

" Tab
set ts=4 sw=4
set expandtab
autocmd FileType svg,javascript,typescript,typescriptreact,groovy,yaml,vue,css,json,vim,xml setlocal ts=2 sw=2 expandtab " Tab of 2 for some files

" Fold with 'zc' and 'zo'
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Keep undo history across sessions, by storing in file.
set undofile
if (!isdirectory("/tmp/undodir"))
  silent !mkdir /tmp/undodir
endif
set undodir=/tmp/undodir


autocmd FileType c set cc=80                   " Show line for 80 columns

" Clang-format
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>


source $HOME/.config/nvim/plugs-set/vimplug.vim

source $HOME/.config/nvim/plugs-set/notify.vim

syntax enable                                   " Enable syntax higllighing

source $HOME/.config/nvim/plugs-set/coc.vim
" source $HOME/.config/nvim/plugs-set/coc-notify.vim

source $HOME/.config/nvim/plugs-set/treesitter.vim
source $HOME/.config/nvim/plugs-set/omnisharp.vim
source $HOME/.config/nvim/plugs-set/airline.vim
source $HOME/.config/nvim/plugs-set/arduino.vim
source $HOME/.config/nvim/plugs-set/better-whitespace.vim
source $HOME/.config/nvim/plugs-set/bufferline.vim
source $HOME/.config/nvim/plugs-set/gitmessenger.vim
source $HOME/.config/nvim/plugs-set/gitgutter.vim
source $HOME/.config/nvim/plugs-set/instant.vim
source $HOME/.config/nvim/plugs-set/mkdp.vim
source $HOME/.config/nvim/plugs-set/nerdtree.vim
source $HOME/.config/nvim/plugs-set/indentline.vim
source $HOME/.config/nvim/plugs-set/rainbow.vim
source $HOME/.config/nvim/plugs-set/vimspector.vim
source $HOME/.config/nvim/plugs-set/nerdcommenter.vim
source $HOME/.config/nvim/plugs-set/haskell.vim
source $HOME/.config/nvim/plugs-set/clang-format.vim
source $HOME/.config/nvim/plugs-set/f.vim
source $HOME/.config/nvim/plugs-set/image-preview.vim
source $HOME/.config/nvim/plugs-set/telescope.vim
" source $HOME/.config/nvim/plugs-set/noice.vim
source $HOME/.config/nvim/plugs-set/todo-comments.vim
" source $HOME/.config/nvim/plugs-set/catppuccin.vim
source $HOME/.config/nvim/plugs-set/nightfox.vim

source $HOME/.config/nvim/keybindings/map.vim
