" Naviguate in buffers
" Go to next
nnoremap <leader>k :BufferLineCycleNext<CR>
" Reorder to prev
nnoremap <leader>mk :BufferLineMoveNext<CR>
" Go to prev
nnoremap <leader>j :BufferLineCyclePrev<CR>
" Reorder to prev
nnoremap <leader>mj :BufferLineMovePrev<CR>
" Close
nnoremap <leader>bq :bp <BAR> bd #<CR>
