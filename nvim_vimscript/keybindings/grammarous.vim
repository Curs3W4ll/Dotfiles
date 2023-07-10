function! FixAndRecheck()
    :execute "normal \<Plug>(grammarous-fixit)"
    :GrammarousCheck<CR>
endfunction

nnoremap <leader>rg :GrammarousCheck<CR>
nnoremap <leader>ro <Plug>(grammarous-open-info-window)
nnoremap <leader>rm <Plug>(grammarous-move-to-info-window)
nnoremap <leader>rf :call FixAndRecheck()<CR>
nnoremap <leader>ra <Plug>(grammarous-fixall)
nnoremap <leader>ri <Plug>(grammarous-remove-error)
nnoremap <leader>rc <Plug>(grammarous-close-info-window)
nnoremap <leader>rn <Plug>(grammarous-move-to-next-error)
nnoremap <leader>rp <Plug>(grammarous-move-to-previous-error)
