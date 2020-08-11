"       __       _______   __        ______
"      /""\     /"     "| /""\      /    " \
"     /    \   (: ______)/    \    // ____  \   Copyright (c) 2020 Andres Angarita
"    /' /\  \   \/    | /' /\  \  /  /    ) :)  https://github.com/angaritaoa
"   //  __'  \  // ___)//  __'  \(: (____/ //   Email: angaritaoa@gmail.com
"  /   /  \\  \(:  (  /   /  \\  \\        /
" (___/    \___)\__/ (___/    \___)\"_____/
"
" Mi configuración personalizada de Vim.

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
set fileencodings=utf-8
set fileencoding=utf-8
set fileformats=unix
set history=1000
set hidden
set hlsearch
set ignorecase
set incsearch
set nocompatible
set number
set omnifunc=syntaxcomplete#Complete
set ruler
set scrolloff=3
set shiftwidth=4
set showcmd
set showmatch
set showtabline=2
set smartcase
set tabstop=4
set ttimeoutlen=50
set ttyfast
set undofile
set undodir=~/.vim/undodir
set backupdir=~/.vim/backupdir
set directory=~/.vim/directory
set fillchars+=vert:\┆

filetype plugin indent on
highlight CursorLine cterm=NONE ctermbg=236
highlight CursorLineNR ctermbg=236
highlight tabLinefill cterm=NONE
highlight VertSplit cterm=NONE ctermbg=NONE ctermfg=8
highlight Folded cterm=reverse ctermbg=0 ctermfg=8

"set termguicolors
syntax enable
"set background=dark
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

