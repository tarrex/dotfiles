" Tarrex's vimrc
"       ------ Enjoy vim, enjoy life.


" ============> General Setting <============

syntax on                       " syntax highlighting

if has('vim_starting')
    set nocompatible            " be iMproved, required
endif

filetype indent plugin on       " filetype detection on 

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
set linebreak
set textwidth=500

" set paste
set pastetoggle=<F4>            " set paste toggle

set history=1000                " set how many lines of command history vim has to remember
set undolevels=1000             " set how many levels of undo

set noerrorbells                " bell settings
set novisualbell
set vb t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

set title                       " change terminal's title
set titleold="Terminal"
set titlestring=%F

set encoding=utf-8
set fileencoding=utf-8          " file encoding setting
set fileencodings=utf-8

set fileformat=unix             " filetypes setting
set fileformats=unix,dos,mac

set autoread                    " auto load the file when changed outside vim
set autowrite                   " auto write file when building"

" set mouse=a                     " automatically enable mouse usage
set mousehide                   " hide mouse cursor while typing"

set report=0                    " show change count

" set updatecount=0               " close swap file

set smartcase                   " searching
set magic
set ignorecase                  " ignore case when search
set incsearch                   " real time show the search case
set hlsearch                    " highlight search
" highlight search cterm=underline ctermfg=white

set laststatus=2                " show status line
" set showcmd                     " show command on status bar
set showmode                    " show mode status

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

set showmatch                   " highlight match \{\}\[\]\(\)

" set foldmarker={,}
" set foldmethod=indent
" set foldlevel=100
" set foldopen-=search
" set foldopen-=undo

set cryptmethod=blowfish2

" set hidden                      " enable hidden buffers

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Ignore the following extensions on file search and completion
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib                               "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
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

" Shortcuts setting
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Remember cursor position
augroup VimRememberCursorPosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Color Setting
set t_Co=256
set background=dark
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    set t_ut=
endif

" ============> Plugin Setting <============
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter', {'on': ['GitGutterToggle', 'GitGutterSignsToggle', 'GitGutterLineHighlightsToggle']}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind']}
Plug 'majutsushi/tagbar', {'on': ['TagbarToggle']}
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for': ['go']}
Plug 'tpope/vim-markdown', {'for': ['markdown', 'md']}
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'valloric/youcompleteme', {'do': './install.py --clang-complete --gocode-completer', 'for': ['go', 'c', 'cpp', 'python', 'javascript']}
Plug 'rdnetto/ycm-generator', {'branch': 'stable'}
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()

" ----> fatih/vim-go setting
" let g:go_addtags_transform = 'camelcase'
let g:go_list_type = "quickfix"
let g:go_fmt_command = 'goimports'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

augroup go
    au!
    au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

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

    au FileType go nmap <F10> <Plug>(go-def)
augroup END

" ----> scrooloose/nerdtree setting
let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" ----> airblade/vim-gitgutter setting
nmap <F7> :GitGutterSignsToggle<CR>
nmap <F8> :GitGutterLineHighlightsToggle<CR>

" ----> vim-airline/vim-airline
let g:airline_symbols = {}
let g:airline_symbols.space = "\ua0"
let g:airline_symbols.branch = 'ᚠ'
let g:airline_symbols.notexists = ' Ɇ'
let g:airline_left_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_sep=''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 0
" let g:airline_theme='powerlineish'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline_section_a = airline#section#create(['mode', 'branch'])

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

" ----> ctrlpvim/ctrlp.vim setting
let g:ctrlp_map = ''
let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
let g:ctrlp_working_path = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
noremap <c-p> :CtrlP<cr>
noremap <c-n> :CtrlPMRUFiles<cr>

" ----> tacahiroy/ctrlp-funky setting
noremap <c-f> :CtrlPFunky<cr>
noremap <c-u> :CtrlPBuffer<cr>

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
nmap <silent> <F6> :TagbarToggle<CR>
let g:tagbar_ctags_bin = "/usr/bin/ctags"
let g:tagbar_autofocus = 1
let g:tagbar_width = 50

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \ ]
\ }

let g:tagbar_type_make = {
    \ 'kinds':[
        \ 'm:macros',
        \ 't:targets'
    \ ]
\ }

let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

" ----> sheerun/vim-polyglot etting
let g:polyglot_disabled = ['python']

" ----> valloric/youcompleteme setting
nmap <leader>gd :YcmDiags<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_python_binary_path='python'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py' "default ycm conf location
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
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
noremap <c-z> <NOP>
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_cache_omnifunc = 0
let g:ycm_semantic_triggers = {
    \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
    \ 'cs,lua,javascript': ['re!\w{2}'],
    \ }
let g:ycm_filetype_whitelist = {
    \ "c":1,
    \ "cpp":1,
    \ "objc":1,
    \ "objcpp":1,
    \ "python":1,
    \ "java":1,
    \ "javascript":1,
    \ "coffee":1,
    \ "vim":1,
    \ "go":1,
    \ "cs":1,
    \ "lua":1,
    \ "perl":1,
    \ "perl6":1,
    \ "php":1,
    \ "ruby":1,
    \ "rust":1,
    \ "erlang":1,
    \ "asm":1,
    \ "nasm":1,
    \ "masm":1,
    \ "tasm":1,
    \ "asm68k":1,
    \ "asmh8300":1,
    \ "asciidoc":1,
    \ "basic":1,
    \ "vb":1,
    \ "make":1,
    \ "cmake":1,
    \ "html":1,
    \ "css":1,
    \ "less":1,
    \ "json":1,
    \ "cson":1,
    \ "typedscript":1,
    \ "haskell":1,
    \ "lhaskell":1,
    \ "lisp":1,
    \ "scheme":1,
    \ "sdl":1,
    \ "sh":1,
    \ "zsh":1,
    \ "bash":1,
    \ "man":1,
    \ "markdown":1,
    \ "matlab":1,
    \ "maxima":1,
    \ "dosini":1,
    \ "conf":1,
    \ "config":1,
    \ "zimbu":1,
    \ "ps1":1,
    \ }

" ----> w0rp/ale setting
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ 'go': ['go build', 'gofmt -e', 'go vet', 'golint'],
       \ 'c': ['gcc', 'cppcheck'], 
       \ 'cpp': ['gcc', 'cppcheck'], 
       \ 'python': ['flake8', 'pylint'], 
       \ 'lua': ['luac'], 
       \ 'java': ['javac'],
    \}
" let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
let g:ale_fixers = {
   \ 'javascript': ['eslint'],
   \ 'python': ['autopep8', 'yapf'],
   \}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
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
" reduce the process priority of ale
if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
    let g:ale_command_wrapper = 'nice -n5'
endif
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

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

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
colorscheme molokai

" ----> keyboard settings
let mapleader=','               " set vim map leader
let g:mapleader=','

nnoremap <silent> <leader><space> :nohlsearch<cr>    " turn off search highlight
nnoremap <leader>sh :sh<cr>     " hold vim and run a shell at this directory, exit will return vim

nnoremap j gj                   " treat long lines as break lines
nnoremap k gk

nnoremap B ^                    " move to beginning/end of line
nnoremap E $

nnoremap $ <nop>                " $/^ doesn't do anything
nnoremap ^ <nop>

nnoremap gV `[v`]               " highlight last inserted text

nnoremap <Leader>tc :tabc<CR>   " close current tab page
nnoremap <Leader>tn :tabn<CR>   " go to the next tab page
nnoremap <Leader>tp :tabp<CR>   " go to the previous tab page
nnoremap <Leader>te :tabe<CR>   " open a new tab page with an empty window

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

function! s:PythonHeader()
    normal i#!/usr/bin/env python
    normal o# -*- coding: utf-8 -*-
    let fullname = ''
    if has('macunix')
        let fullname = split(system("finger `whoami` | awk -F: '{ print $3  }' | head -n1 | sed 's/^ //'"), '\n')[0]
    elseif has('unix')
        let fullname = split(system('whoami | head -n1'), '\n')[0]
    endif
    if fullname != ''
        let @o = "# by " . fullname . " " . strftime("%Y-%m-%d %H:%M:%S")
        put o
    endif
    normal o
endfunction

augroup PythonHeader
    autocmd BufNewFile *.py call s:PythonHeader()
augroup END
