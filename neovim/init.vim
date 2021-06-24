"       __       _______   __        ______
"      /""\     /"     "| /""\      /    " \
"     /    \   (: ______)/    \    // ____  \   Copyright (c) 2020 Andres Angarita
"    /' /\  \   \/    | /' /\  \  /  /    ) :)  https://github.com/angaritaoa
"   //  __'  \  // ___)//  __'  \(: (____/ //   Email: angaritaoa@gmail.com
"  /   /  \\  \(:  (  /   /  \\  \\        /
" (___/    \___)\__/ (___/    \___)\"_____/
"
" Mi configuración personalizada de neovim
"
" set guicursor=a:blinkon100

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
set ruler
set scrolloff=3
set shiftwidth=4
set showcmd
set showmatch
set showtabline=2
set smartcase
set tabstop=4
set ttimeoutlen=50
"set ttyfast
set undofile
"set undodir=~/.vim/undodir
"set backupdir=~/.vim/backupdir
"set directory=~/.vim/directory
set fillchars+=vert:\┆

"filetype plugin indent on
"highlight CursorLine cterm=NONE ctermbg=236
"highlight CursorLineNR ctermbg=236
"highlight tabLinefill cterm=NONE
"highlight VertSplit cterm=NONE ctermbg=NONE ctermfg=8
"highlight Folded cterm=reverse ctermbg=0 ctermfg=8

set termguicolors
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

"autocmd BufWritePre * :%s/\s\+$//e


" -------------
set background=dark

set termguicolors

set cursorline

hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "vimatom"

hi Normal guibg=#282C34
hi NonText guifg=bg
hi comment guifg=#5C6370
hi string guifg=#98C379
hi number guifg=#B5CEA8
hi special guifg=#56B6C2
hi constant guifg=#D19A66
hi operator guifg=#C678DD
hi type guifg=#56B6C2
hi statement guifg=#C678DD
hi preproc guifg=#C678DD
hi Visual guibg=#3E4451
hi StatusLine guifg=#21252B guibg=#9DA5B4
hi LineNr guifg=#636D83
hi CursorLine cterm=NONE guibg=NONE
hi CursorLineNr cterm=NONE guifg=#ABB2BF

set laststatus=2

set statusline=%f\ %l:%c%=%y
