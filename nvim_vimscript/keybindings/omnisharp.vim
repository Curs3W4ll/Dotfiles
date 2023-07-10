" Formatting selected code
xmap <leader>f  :OmniSharpCodeFormat<CR>
nmap <leader>f  :OmniSharpCodeFormat<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :OmniSharpDocumentation<CR>

" Code navigation
nmap <silent> gd :OmniSharpGotoDefinition<CR>
nmap <silent> gi :OmniSharpFindImplementations<CR>
nmap <silent> gr :OmniSharpFindUsages<CR>

" Code navigation previews
nmap <silent> pgd :OmniSharpPreviewDefinition<CR>
nmap <silent> pgi :OmniSharpPreviewImplementation<CR>

" Code actions
nmap <leader>ac  :OmniSharpGetCodeActions<CR>

" Symbol renaming.
nmap <C-f> :OmniSharpRename<CR>
