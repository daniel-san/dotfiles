let g:coc_global_extensions = [
\    'coc-explorer',
\    'coc-css',
\    'coc-emmet',
\    'coc-git',
\    'coc-highlight',
\    'coc-html',
\    'coc-java',
\    'coc-json',
\    'coc-omnisharp',
\    'coc-phpls',
\    'coc-prettier',
\    'coc-python',
\    'coc-snippets',
\    'coc-tag',
\    'coc-tailwindcss',
\    'coc-tsserver',
\    'coc-ultisnips',
\    'coc-vetur',
\    'coc-yaml',
\    'coc-yank',
\]

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <silent> <leader>ch :call CocActionAsync('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>cs :call CocActionAsync('workspaceSymbols')<CR>
nnoremap <silent> <leader>ce :call CocActionAsync('documentSymbols')<CR>
nmap <leader>cn <Plug>(coc-rename)
nmap <leader>cf <Plug>(coc-format)
vmap <leader>cf <Plug>(coc-format-selected)
vmap <leader>cq <Plug>(coc-fix-current)
