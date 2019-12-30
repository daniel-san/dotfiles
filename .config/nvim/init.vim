if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$HOME/.config/nvim/plugged')
" Use release branch
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Raimondi/delimitMate' " Abre e fecha {}[]()
Plug 'lokaltog/neoranger', { 'as': 'ranger' } " Ranger file manager for vim
Plug 'mhinz/vim-signify' " adicionar marcação caso tenha mudança no git
Plug 'mhinz/vim-startify',
Plug 'ntpeters/vim-better-whitespace' " Linhas de identação e remoção de espaços
Plug 'vim-airline/vim-airline' " status line
Plug 'vim-airline/vim-airline-themes' " status line tunada
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets', { 'as': 'vim-snippets'}
Plug 'APZelos/blamer.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jremmen/vim-ripgrep'
Plug 'Chiel92/vim-autoformat'
call plug#end()

runtime _configs/coc.vim

"===============================================================================

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
set colorcolumn=80,120
set showmatch
set showmode
set nowrap

set foldmethod=indent
set foldnestmax=10
set foldlevel=2
set nofoldenable

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

"===============================================================================

" FZF Stuff
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <leader>o :<C-u>Files<cr>

command! -bang -nargs=* FRg
   \ call fzf#vim#grep(
       \ 'rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
       \ <bang>0 ? fzf#vim#with_preview('down:80%')
               \ : fzf#vim#with_preview('right:50%:hidden', '?'),
       \ <bang>0)

" Search the word under cursor with ripgrep
map <F2> :Rg<CR>
" Regular ripgrep search
map <F3> :Rg 
" Regular 'ripgrep' search using fzf
map <leader><space> :FRg 

"===============================================================================

"let s:default_path = escape(&path, '\ ') " store default value of 'path'

let g:blamer_enabled = 1

"Theme
set background=dark
colorscheme dracula
highlight ColorColumn ctermbg=1
highlight Normal ctermbg=none

set termguicolors

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

vnoremap <C-c> "*y :let @+=@*<CR>
map <C-p> "+p

"Spell checker
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F7> :setlocal spell! spelllang=pt_br<CR>

"Mappings for termguicolors
map <F10> :set termguicolors!<CR>

"Integrated terminal
map <F4> :tabnew \| :terminal<CR>
map <S-F4> :vsp \| :terminal<CR>
map <Leader>4 :bot 10split \| :terminal <CR>

"moving tabs
nmap <F12> :tabmove +1 <CR>
nmap <F11> :tabmove -1 <CR>

"kitty specific
map <F16> :vsp \| :terminal<CR>

"===============================================================================

" ========== Ranger Mappings ==========
nnoremap <silent> - :Ranger<CR>
nnoremap <silent> <Leader>r :RangerCurrentFile<CR>

"Open Ranger on a new tab
nnoremap <silent> <Leader>t :tabnew \| RangerCurrentFile<CR>
nnoremap <silent> <Leader>f :tabnew \| Ranger<CR>

"Open ranger in a new split window
" Ranger on Vertial Split
nnoremap <silent> <Leader>v :vsp \| RangerCurrentFile<CR>

" Ranger on Horizontal Split
nnoremap <silent> <Leader>h :split \| RangerCurrentFile<CR>

" ========== CocSnippet Mappings ==========
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

" ========== Coc Explorer ==========
nmap <Leader>e :CocCommand explorer<CR>
