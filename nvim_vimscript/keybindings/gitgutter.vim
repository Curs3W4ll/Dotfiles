" Show preview popup
:nmap <leader>gp :GitGutterPreviewHunk<CR>
" HighLight modified lines
:nmap <leader>gh :GitGutterLineHighlightsToggle<CR>
" Reduce unchanging lines
:nmap <leader>gf :GitGutterFold<CR>
" Go to next change
:nmap <leader>gn :GitGutterNextHunk<CR>:GitGutterPreviewHunk<CR>
" Go to previous change
:nmap <leader>gN :GitGutterPrevHunk<CR>:GitGutterPreviewHunk<CR>
" Rollback changes
:nmap <leader>gu :GitGutterUndoHunk<CR>
