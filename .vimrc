" ===> General

" Compatible settings
set nocompatible

" Show command history
set history=500

" Cancle IME on Normal mode
"InsertLeave *    set imdisable
"InsertEnter *    set noimdisable

" Open plugin and indent
"filetype plugin indent on

" Use mouse on console
"set mouse=a
"set mousehide

" Bell settings
set noerrorbells
set visualbell

" Endocidng settings
set fileencoding=UTF-8
set fileencodings=ucs-bom,UTF-8,GBK,BIG5,latin1

" Auto read file when changed outside vim
"set autoread

" Show change count
set report=0

" Filetypes settings
set fileformat=unix

" Backspace key can delete anything on insert mode
set backspace=2

" Do not use swap file
set updatecount=0

" ===> Interface
" Show line number
"set number

" Show status line
set laststatus=2

" Show command on status bar
set showcmd

" Hide mode status in status line
set noshowmode

" Always show current position
set ruler

" Add underline for the cursor's line
"set cursorline

if has("gui_running")
    set lines=25
    set columns=80
    set lazyredraw  " Lazyredraw
    set guioptions-=m   " Hide menu bar
    set guioptions-=T   " Hide tool bar
    set guifont=consolas\ 10
endif

" ===> Colors
" Syntax highlight on
syntax on

" Colorscheme
set t_Co=256

"colorscheme colorful

"-- Solarized colorschema
set background=dark
let g:solarized_termcolors=256      " 16 | 256 
let g:solarized_termtrans=1         " 0 | 1 
let g:solarized_degrade=1           " 0 | 1 
let g:solarized_bold=1              " 1 | 0 
let g:solarized_underline=1         " 1 | 0 
let g:solarized_italic=1            " 1 | 0 
let g:solarized_contrast="normal"   "normal | high or low
let g:solarized_visibility="normal" "normal | high or low
colorscheme solarized

" ===> Search
" Ignorecase when search
set ignorecase

" Dynamic insert the case
set incsearch

" Highlight search
set hlsearch

" Paren-matching settings
set showmatch

set smartcase
set magic

" ===> Indent
" Indentation and tab settings
"set autoindent
"set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set ambiwidth=double

" Wrap lines setting
"set wrap

" Paste settings
"set paste
set pastetoggle=<F4>

" ===> Folding
"set foldmarker={,}
"set foldmethod=indent
"set foldlevel=100
"set foldopen-=search
""set foldopen-=undo

" ===> Backup
set backupcopy=yes
set nobackup

" ===> Key shortcut
nmap <C-t>   :tabnew<cr>
nmap <C-p>   :tabprevious<cr>
nmap <C-n>   :tabnext<cr>
nmap <C-k>   :tabclose<cr>
nmap <C-Tab> :tabnext<cr> 

" ===> Plugin
" Pathogen
call pathogen#infect()

" Powerline
set guifont=PowerlineSymbols\ for\ Powerline
"set nocompatible
"set t_Co=256
let g:Powerline_symbols = 'fancy'
