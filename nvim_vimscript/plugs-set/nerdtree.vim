" Show hidden files
let NERDTreeShowHidden=1

" Ignore files and folders
let NERDTreeIgnore=['\.git$', '\.vscode$', '\.clangd$', '\.cache$', 'node_modules$', 'compile_commands.json', '\.o$', '\.a$', '\.gcda$', '\.gcno$', 'vgcore\.', '\.hi$', 'build$', 'bin$', 'obj$']

" When open a directory, start tree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Close tree if it's the last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Setup icons
set encoding=UTF-8

" NERDTree-git icons
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'~',
                \ 'Staged'    :'✭',
                \ 'Untracked' :'✚',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" NERDTree-git show ignored status
let g:NERDTreeGitStatusShowIgnored = 1

" Align NERDTree-git icons
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
