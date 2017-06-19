" Tarrex's vimrc
"       ------ Especially for a golang/python programmer.
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

" set autoindent
" set smartindent
" set cindent

" set wrap                      " wrap line
set lbr
set tw=500

" set paste
set pastetoggle=<F4>            " set paste toggle

set history=10000               " set how many lines of command history vim has to remember

set noerrorbells                " bell settings
set visualbell

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
set nowb
set noswapfile

" set foldmarker={,}
" set foldmethod=indent
" set foldlevel=100
" set foldopen-=search
" set foldopen-=undo


" ============> Plugin Setting <============

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" git plugin
Plugin 'tpope/vim-fugitive'

" interface plugin
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'

" Tag plugin
Plugin 'majutsushi/tagbar'

" Golang
Plugin 'fatih/vim-go'

" Python
Plugin 'python-mode/python-mode'

" Markdown
Plugin 'tpope/vim-markdown'

" Utils
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'sirver/ultisnips'
Plugin 'godlygeek/tabular'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ----> majutsushi/tagbar setting
nmap <F8> :TagbarToggle<CR>
let g:tagbar_ctags_bin="/usr/bin/ctags"
let g:tagbar_width=50

" ----> fatih/vim-go setting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
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

" ----> python-mode/python-mode setting
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
" Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = "<C-S-e>"
" Override view python doc key shortcut to Ctrl-Shift-d
let g:pymode_doc_bind = "<C-S-d>"

" ----> scrooloose/nerdtree setting
" nmap <leader>ne :NERDTreeToggle<CR>
" nmap <leader>ne :NERDTreeToggle<CR>
nmap <F6> :NERDTreeToggle<CR>

" ----> vim-airline/vim-airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
if !exists('g:airline_powerline_fonts')
	let g:airline_left_step='>'
	let g:airline_right_strp='<'
endif
let g:airline_symbols.space = "\ua0"
" let g:airline_theme='solarized'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_a=airline#section#create(['mode', 'branch'])
" let g:airline_section_b='%{strftime("%c")}'
let g:airline_section_y='BN: %{bufnr("%")}'

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

" ----> shougo/neocomplete.vim setting
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions'
"     \ }

" Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ----> kien/ctrlp.vim setting
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|o|pyc)$',
  \ }

" ----> tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" ----> sirver/ultisnips setting
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ----> nathanaelkane/vim-indent-guides setting
" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=0
let g:indent_guides_color_change_percent=30
" hi IndentGuidesOdd  ctermbg=245
" hi IndentGuidesEven ctermbg=249

" ----> Valloric/YouCompleteMe setting
nmap <leader>gd :YcmDiags<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_path_to_python_interpreter="/usr/bin/python"
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py' "default ycm conf location
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_confirm_extra_conf = 0 "no annoying tips on vim starting
" let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_cache_omnifunc = 0
" let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 0
" let g:ycm_filetype_blacklist = {'tex' : 1, 'markdown' : 1, 'text' : 1, 'html' : 1}
" let g:syntastic_ignore_files = [".*\.py$"] "python has its own check engine
" let g:ycm_semantic_triggers = {}
" let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
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
if has("gui_running")
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
colorscheme candy

" ----> keyboard settings
let mapleader=","               " set vim map leader
let g:mapleader=","

nnoremap <leader><space> :nohlsearch<cr>    " turn off search highlight
nnoremap <leader>sh :sh<cr>     " hold vim and run a shell at this directory, exit will return vim

nnoremap j gj                   " treat long lines as break lines
nnoremap k gk

nnoremap B ^                    " move to beginning/end of line
nnoremap E $

nnoremap $ <nop>                " $/^ doesn't do anything
nnoremap ^ <nop>

nnoremap gV `[v`]               " highlight last inserted text

nmap <C-t>   :tabnew<cr>        " tab operation shortcut
nmap <C-p>   :tabprevious<cr>
nmap <C-n>   :tabnext<cr>
nmap <C-k>   :tabclose<cr>
nmap <C-Tab> :tabnext<cr>

" ----> custom function
function! AddPythonHeader()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    call append(2, "# Author: T.C")
    call append(3, "# Version: 1.0")
    call append(4, "# Created: " . strftime("%Y-%m-%d %H:%M:%S %Z", localtime()))
    call append(5, "# Last Modified: " . strftime("%Y-%m-%d %H:%M:%S %Z", localtime()))
    normal G
    normal o
endf

function! AddBashHeader()
    call setline(1, "#!/bin/bash")
    call append(1, "# Author: T.C")
    call append(2, "# Version: 1.0")
    call append(3, "# Created: " . strftime("%Y-%m-%d %H:%M:%S %Z", localtime()))
    call append(4, "# Last Modified: " . strftime("%Y-%m-%d %H:%M:%S %Z", localtime()))
    normal G
    normal o
endf

" function! AddGolangHeader()
"     call setline(1, "/*")
"     call append(1, "* Author: T.C")
"     call append(2, "* Version: 1.0")
"     call append(3, "* Created: " . strftime("%Y-%m-%d %H:%M:%S %Z", localtime()))
"     call append(4, "* Last Modified: " . strftime("%Y-%m-%d %H:%M:%S %Z", localtime()))
"     call append(5, "*/")
"     call append(3, "package " . dirname())
"     normal G
"     normal o
" endf

autocmd bufnewfile *.py call AddPythonHeader()
autocmd bufnewfile *.sh call AddBashHeader()
" autocmd bufnewfile *.go call AddGolangHeader()

" reference: http://vim.wikia.com/wiki/Insert_current_date_or_time
function! AutoInsertModifiedTime()
	let s:original_pos = getpos(".")
	let s:regexp = "^\s*\([#\"\*]\|\/\/\)\s\?[lL]ast [mM]odified:"
	let s:lu = search(s:regexp)
	if s:lu != 0
		let s:update_str = matchstr(getline(s:lu), s:regexp)
		call setline(s:lu, s:update_str . strftime(" %Y-%m-%d %H:%M:%S %Z"))
		call setpos(".", s:original_pos)
	endif
endfunction
autocmd InsertLeave *.{py,go,c,cpp,js,css},*vimrc call AutoInsertModifiedTime()
" autocmd BufWritePre *.{py,go,c,cpp,js,css},*vimrc call AutoInsertModifiedTime()
" autocmd BufWritePost *.{py,go,c,cpp,js,css},*vimrc call AutoInsertModifiedTime()

" highlight some special strings
highlight hs cterm=bold term=bold ctermbg=yellow ctermfg=black
match hs /\(TODO\)/

autocmd bufwritepost .vimrc source $MYVIMRC
