" Tarrex's vimrc
"       ------ Enjoy vim, enjoy life.


" ============> General Setting <============

syntax on                       " syntax highlighting

set nocompatible                " be iMproved, required

filetype off                    " close filetype detection
filetype plugin on              " plugin for specific filetypes on 
filetype indent on              " indent for specific filetypes on

set showmatch                   " highlight match \{\}\[\]\(\)

set smartcase
set magic

set number
set ruler

set backspace=indent,eol,start  " same as set backspace=2 set backspace key can delete anything on insert mode

set expandtab                   " covert tabs to spaces

set shiftwidth=4                " 1 tabs == 4 spaces 
set tabstop=4                   " number of visual spaces per tab
set softtabstop=4               " number of spaces in tab when editing
set smarttab                    " be smart when use tabs

set ambiwidth=double

set autoindent
" set smartindent
set cindent

" set wrap                      " wrap line
set lbr
set tw=500

" set paste
set pastetoggle=<F4>            " set paste toggle

set history=10000               " set how many lines of command history vim has to remember

set noerrorbells                " bell settings
set novisualbell

set encoding=utf-8
set fileencoding=UTF-8          " file encoding setting
set fileencodings=UTF-8,GBK,BIG5,latin1

set fileformat=unix             " filetypes setting

set autoread                    " auto load the file when changed outside vim
set autowrite                   " auto write file when building"

" set mouse=a                     " automatically enable mouse usage
set mousehide                   " hide mouse cursor while typing"

set report=0                    " show change count

" set updatecount=0               " close swap file

set ignorecase                  " ignore case when search
set incsearch                   " real time show the search case
set hlsearch                    " highlight search
" highlight search cterm=underline ctermfg=white

set laststatus=2                " show status line
" set showcmd                     " show command on status bar
set showmode                    " show mode status
" set noshowmode                  " hide mode status in status line

set cursorline                  " show underline for the cursor's line
" set cursorcolumn                " show column line for the cursor's column

set wildmenu                    " show autocomplete for command menu

set lazyredraw                  " don't redraw while executing macros

" InsertLeave *   set imdisable   " cancle IME on normal mode
" InsertEnter *   set noimdisable

" set backupcopy=yes              " backup setting
set nobackup
set nowritebackup
set noswapfile
set noundofile

" set foldmarker={,}
" set foldmethod=indent
" set foldlevel=100
" set foldopen-=search
" set foldopen-=undo

set cm=blowfish2

" Ignore the following extensions on file search and completion
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib                               "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz             " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android


" ============> Plugin Setting <============

" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" git plugin
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" interface plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind']}
Plug 'yggdroot/indentline'

" Tag plugin
Plug 'majutsushi/tagbar'

" Golang
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for': ['go']}

" Markdown
Plug 'tpope/vim-markdown', {'for': ['markdown', 'md']}

" Utils
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'valloric/youcompleteme', {'for': ['go', 'c', 'cpp', 'python', 'javascript']}
Plug 'rdnetto/ycm-generator', {'branch': 'stable'}
Plug 'w0rp/ale'
Plug 'tpope/vim-unimpaired'

" Initialize plugin system
call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" ----> fatih/vim-go setting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_generate_tags = 1

" Enable highlighting of variables that are the same
" let g:go_auto_sameids = 1
" Show type information in status line
" let g:go_auto_type_info = 1
" Run :GoAddTags. usually want snakecase properties, but it also supports camelcase.
let g:go_decls_includes = 'func,type'
let g:go_addtags_transform = 'snakecase'
let g:go_fmt_command = 'goimports'
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>co <Plug>(go-coverage)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>gt :GoDeclsDir<cr>
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

au FileType go nmap <F12> <Plug>(go-def)

" ----> scrooloose/nerdtree setting
nmap <F8> :NERDTreeToggle<CR>

" ----> yggdroot/indentline setting
let g:indentLine_enabled = 0
let g:indentLine_char = 'c'    " c, ¦, ┆, │, or ▏
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 232
let g:indentLine_bgcolor_term = 240
"let g:indentLine_concealcursor = 'inc'
"let g:indentLine_conceallevel = 2
let g:indentLine_setConceal = 0
nmap <F10> :IndentLinesToggle<CR>

" ----> mhinz/vim-signify setting
let g:signify_disable_by_default = 1
nmap <F7> :SignifyToggle<CR>

" ----> vim-airline/vim-airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
if !exists('g:airline_powerline_fonts')
	let g:airline_left_sep=''
	let g:airline_right_sep=''
endif
let g:airline_symbols.space = "\ua0"
let g:airline_symbols.branch = 'ᚠ'
" let g:airline_theme='solarized'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_a=airline#section#create(['mode', 'branch'])
" let g:airline_section_y='BN: %{bufnr("%")}'

" ----> scrooloose/nerdcommenter setting
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ----> kien/ctrlp.vim setting
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ----> tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" ----> sirver/ultisnips setting
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

" ----> majutsushi/tagbar setting
nmap <F9> :TagbarToggle<CR>
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=50

" ----> valloric/youcompleteme setting
nmap <leader>gd :YcmDiags<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_python_binary_path='python'
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py' "default ycm conf location
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_confirm_extra_conf = 0 "no annoying tips on vim starting
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_key_invoke_completion = '<c-/>'
set completeopt=menu,menuone
noremap <c-/> <NOP>
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_cache_omnifunc = 0
let g:ycm_filetype_blacklist = {
            \ 'tex'     : 1,
            \ 'markdown': 1,
            \ 'text'    : 1,
            \ 'html'    : 1,
            \ 'tagbar'  : 1,
            \ 'qf'      : 1,
            \ 'notes'   : 1,
            \ 'unite'   : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc'  : 1,
            \ 'infolog' : 1,
            \ 'mail'    : 1
            \ }
" let g:syntastic_ignore_files = [".*\.py$"] "python has its own check engine
let g:ycm_semantic_triggers = {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
let g:ycm_filetype_whitelist = {
            \ 'c'       : 1,
            \ 'cpp'     : 1,
            \ 'go'      : 1,
            \ 'sh'      : 1,
            \ 'java'    : 1,
            \ 'python'  : 1
            \ }

" ----> w0rp/ale setting
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \   'go': ['gofmt -e', 'go vet', 'golint'],
            \}
" let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_sign_column_always = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_insert_leave = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
                    \   '%dW %dE',
                    \   all_non_errors,
                    \   all_errors
                    \)
endfunction

set statusline=%{LinterStatus()}
set statusline+=%*

let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
" let g:ale_keep_list_window_open = 1

" ============> Custom Setting <============

" ----> GUI settings
if has('gui_running')
    set lines=25
    set columns=80
    set lazyredraw
    set guioptions-=m             " hide menu bar
    set guioptions-=T             " hode tool bar
    set guifont=consolas\ 10
    set gcr=a:blinkon0            " disable cursor blink
endif

" ----> colorscheme settings
set t_Co=256
set background=dark 
colorscheme cobalt2

" ----> keyboard settings
let mapleader=','               " set vim map leader
let g:mapleader=','

nnoremap <leader><space> :nohlsearch<cr>    " turn off search highlight
nnoremap <leader>sh :sh<cr>     " hold vim and run a shell at this directory, exit will return vim

nnoremap j gj                   " treat long lines as break lines
nnoremap k gk

nnoremap B ^                    " move to beginning/end of line
nnoremap E $

nnoremap $ <nop>                " $/^ doesn't do anything
nnoremap ^ <nop>

nnoremap gV `[v`]               " highlight last inserted text

nmap <m-t>   :tabnew<cr>        " tab operation shortcut
nmap <m-p>   :tabprevious<cr>
nmap <m-n>   :tabnext<cr>
nmap <m-k>   :tabclose<cr>
nmap <m-tab> :tabnext<cr>

" Highlight some special strings
highlight hs cterm=bold term=bold ctermbg=yellow ctermfg=black
match hs /\(TODO\)/

" Terminal setting
if has('terminal') && exists(':terminal') == 2
	if exists('##TerminalOpen')
		augroup VimUnixTerminalGroup
			au!
			au TerminalOpen * setlocal nonumber signcolumn=no
		augroup END
	endif
endif

