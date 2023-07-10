" Setup leader
let mapleader=","

" Movements
inoremap jk <Esc>
inoremap kj <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>
inoremap jK <Esc>
inoremap Jk <Esc>
inoremap Kj <Esc>
inoremap kJ <Esc>

" Window changements
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Git mergetool
if &diff
    map <leader>1 :diffget LOCAL<CR>
    map <leader>2 :diffget BASE<CR>
    map <leader>3 :diffget REMOTE<CR>
endif

"" Ctrl+S saving
nmap <C-s> :x<CR>
imap <C-s> <Esc>:x<CR>

nmap <leader><Space> zR
map // :noh<CR>

" Visual replace
vnoremap <C-r> "hy:%s/<C-r>h/<C-r>h/gI<left><left><left>

" Space to fold
nmap <silent><nowait> <Space> za
nmap <nowait> <leader><C-r> :so $MYVIMRC<CR>:lua require("reload").reload_nvim_configuration()<CR>

nnoremap <Up><Up><Down><Down><Left><Right><Left><Right>ba<Space> :qa!<CR>
nnoremap <Up><Up><Down><Down><Left><Right><Left><Right>ba<Enter> :qa!<CR>

nmap n nzz
nmap N Nzz

nmap <leader>n <leader>nzz
nmap <leader>N <leader>Nzz

source $HOME/.config/nvim/keybindings/arduino.vim
source $HOME/.config/nvim/keybindings/gitgutter.vim
source $HOME/.config/nvim/keybindings/mkdp.vim
source $HOME/.config/nvim/keybindings/nerdtree.vim
source $HOME/.config/nvim/keybindings/cmake.vim
source $HOME/.config/nvim/keybindings/coc.vim
source $HOME/.config/nvim/keybindings/grammarous.vim
source $HOME/.config/nvim/keybindings/telescope.vim
source $HOME/.config/nvim/keybindings/bufferline.vim

autocmd FileType cs source $HOME/.config/nvim/keybindings/omnisharp.vim
