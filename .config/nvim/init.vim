call plug#begin()
" Use release branch
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Raimondi/delimitMate' " Abre e fecha {}[]()
Plug 'lokaltog/neoranger', { 'as': 'ranger' } " Ranger file manager for vim
Plug 'ntpeters/vim-better-whitespace' " Linhas de identação e remoção de espaços
Plug 'vim-airline/vim-airline' " status line
Plug 'vim-airline/vim-airline-themes' " status line tunada
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets', { 'as': 'vim-snippets'}

call plug#end()

"Options
set encoding=utf-8
set nobackup
set noswapfile      " do not create swap (.swp) files
set history=500     " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set mouse=a         " enable mouse in terminal
set hlsearch        " highlight search results
set autoindent      " always set autoindenting on
set number          " show lines number
set background=dark
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ruler
set nocursorline
set colorcolumn=80
set showmatch
set showmode
set nowrap
"set termguicolors
if has("gui_running")
  set guifont=mononoki\ 14
endif
"set linespace=16
syntax on

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif

"Theme
set background=light
colorscheme dracula
highlight ColorColumn ctermbg=1
highlight Normal ctermbg=none

vnoremap <C-c> "*y :let @+=@*<CR>
map <C-p> "+p

"Spell checker
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F7> :setlocal spell! spelllang=pt_br<CR>

"Mappings for termguicolors
map <F9> :set termguicolors<CR>
map <F10> :set termguicolors!<CR>

"Mappings for ranger
nnoremap <silent> - :Ranger<CR>
nnoremap <silent> <Leader>r :RangerCurrentFile<CR>

"Open Ranger on a new tab
nnoremap <silent> <Leader>t :tabnew \| RangerCurrentFile<CR>
nnoremap <silent> <Leader>f :tabnew \| Ranger<CR>

"Open ranger in a new split window
nnoremap <silent> <Leader>v :vsp \| RangerCurrentFile<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
