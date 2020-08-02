"
" ~/.vimrc
"

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buf_label_first = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_tab_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'

set autoindent
set autoread
set autowrite
set confirm
set cursorline
set encoding=utf-8
set expandtab
set fileencodings=utf-8
set fileencoding=utf-8
set fileformats=unix
set hidden
set hlsearch
set ignorecase
set incsearch
set nobackup
set nocompatible
set noswapfile
set nowrap
set number
set omnifunc=syntaxcomplete#Complete
set ruler
set scrolloff=3
set shiftwidth=4
set showcmd
set showmatch
set showtabline=2
set smartcase
set softtabstop=4
set tabstop=4
set t_Co=256
set ttimeoutlen=50
set ttyfast

filetype plugin indent on
highlight CursorLine cterm=NONE ctermbg=236
highlight CursorLineNR ctermbg=236
highlight tabLinefill cterm=none

syntax enable
set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized

nmap <ESC><ESC> :nohlsearch<CR>

nmap <S-Tab> :bnext<CR>
nmap <S-Up> <C-W><Up>
nmap <S-Down> <C-W><Down>
nmap <S-Left> <C-W><Left>
nmap <S-Right> <C-W><Right>

tmap <S-Tab> <C-W>:bnext<CR>
tmap <S-Up> <C-W><Up>
tmap <S-Down> <C-W><Down>
tmap <S-Left> <C-W><Left>
tmap <S-Right> <C-W><Right>

autocmd BufWritePre * :%s/\s\+$//e
