"       __       _______   __        ______
"      /""\     /"     "| /""\      /    " \
"     /    \   (: ______)/    \    // ____  \   Copyright (c) 2020 Andres Angarita
"    /' /\  \   \/    | /' /\  \  /  /    ) :)  https://github.com/angaritaoa
"   //  __'  \  // ___)//  __'  \(: (____/ //   Email: angaritaoa@gmail.com
"  /   /  \\  \(:  (  /   /  \\  \\        /
" (___/    \___)\__/ (___/    \___)\"_____/
"
" Mi configuración general para neovim. Este archivo debe ser incluido con el
" comando source de neovim

" set leader key

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set fileformats=unix
set ruler           		            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4							" Number of visual spaces per TAB
set softtabstop=4						" Number of spaces in tab when editing
set shiftwidth=4						" Number of spaces to use for autoindent
set expandtab							" Tabs are space
set autoindent
set copyindent							" Copy indent from the previous line
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set history=1000
set scrolloff=3
set showcmd
set showtabline=2
set smartcase
set termguicolors

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0744)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0744)
endif
set undodir=~/.vim/undo-dir
set undofile
