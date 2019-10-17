" Tarrex's vimrc
"       ------ Enjoy vim, enjoy life.

" ============> General <============

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

set autoindent                  " copy indent from current line when starting a new line
" set smartindent               " do smart autoindenting when starting a new line
set cindent                     " enables automatic c program indenting
set breakindent                 " every wrapped line will continue visually indented

set wrap                        " wrap line
set breakat=                    " line break character ' ', default are ' ^I!@*-+;:,./?'
set linebreak

set pastetoggle=<F4>            " set paste toggle

set history=1000                " set how many lines of command history vim has to remember
set undolevels=1000             " set how many levels of undo

set noerrorbells                " bell settings
set novisualbell
set visualbell t_vb=
if has('autocmd')
    augroup VBForGUIEnter
        autocmd!
        autocmd GUIEnter * set visualbell t_vb=
    augroup End
endif

set title                       " change terminal's title
set titleold="Terminal"
set titlestring=%F

set encoding=utf-8
set fileencoding=utf-8          " file encoding setting
set fileencodings=utf-8,big5-hkscs,utf8,iso8859-1

set fileformat=unix             " filetypes setting
set fileformats=unix,dos,mac

set autoread                    " auto load the file when changed outside vim
set autowrite                   " auto write file when building"

" set mouse=a                   " automatically enable mouse usage
set mousehide                   " hide mouse cursor while typing"

set report=0                    " show change count

" set updatecount=0             " close swap file

set smartcase                   " searching
set magic
set ignorecase                  " ignore case when search
set incsearch                   " real time show the search case
set hlsearch                    " highlight search
" highlight search cterm=underline ctermfg=white

set laststatus=2                " show status line
" set showcmd                   " show command on status bar
set showmode                    " show mode status

set cursorline                  " show underline for the cursor's line
" set cursorcolumn              " show column line for the cursor's column

set wildmenu                    " show autocomplete for command menu

set lazyredraw                  " don't redraw while executing macros

set splitbelow                  " horizontally split below
set splitright                  " vertically split to the right

" InsertLeave *   set imdisable   " cancle IME on normal mode
" InsertEnter *   set noimdisable

" set backupcopy=yes            " backup setting
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

set hidden                      " enable hidden buffers

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

set dictionary+=/usr/share/dict/words " dictionary for x mode <c-x> -> <c-n> or <c-k>

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

" ============> Plugins <============
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if !filereadable(vimplug_exists)
    if !executable('curl')
        echoerr 'You have to install curl or first install vim-plug yourself!'
        execute 'q!'
    endif
    echo 'Installing Vim-Plug...'
    echo ''
    silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup PluginInstallForVimEnter
        autocmd!
        autocmd VimEnter * PlugInstall
    augroup END
endif

" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter', {'on': ['GitGutterSignsToggle', 'GitGutterLineHighlightsToggle']}
Plug 'itchyny/lightline.vim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for': 'go'}
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'ycm-core/youcompleteme', {'do': './install.py --clang-completer --gocode-completer --rust-completer',
                             \ 'for': ['c', 'cpp', 'go', 'java', 'javascript', 'python', 'rust', 'typescript']}

" Initialize plugin system
call plug#end()

" ----> fatih/vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
" let g:go_list_type = "quickfix"
" let g:go_addtags_transform = 'camelcase'
let g:go_def_reuse_buffer = 1
let g:go_decls_mode = 'ctrlp.vim'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

augroup go
    autocmd!
    " :GoBuild and :GoTestCompile
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    " :GoTest
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go nmap <leader>tf  <Plug>(go-test-func)
    " :GoRun
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    " :GoDoc
    autocmd FileType go nmap <Leader>d <Plug>(go-doc)
    " :GoCoverageToggle
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    " :GoInfo
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    " :GoMetaLinter
    autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
    " :GoDef but opens in a vertical split
    autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
    " :GoDef but opens in a horizontal split
    autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
    " :GoAlternate  commands :A, :AV, :AS and :AT
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

" ----> scrooloose/nerdtree
let g:NERDTreeChDirMode = 1
let g:NERDTreeMarkBookmarks = 0
let g:NERDTreeAutoDeleteBuffer = 1
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" ----> airblade/vim-gitgutter
nmap <F6> :GitGutterSignsToggle<CR>
nmap <F7> :GitGutterLineHighlightsToggle<CR>
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" ----> itchyny/lightline.vim
set showtabline=2  " show tabline
set guioptions-=e  " don't use GUI tabline
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'venv', 'readonly', 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'filename': 'LightlineFilename',
    \   'venv': 'virtualenv#statusline'
    \ },
    \ 'tabline': {
	\   'left': [ [ 'tabs' ] ],
	\   'right': []
    \ },
    \ 'tab': {
	\   'active': [ 'filename', 'modified' ],
    \   'inactive': [ 'filename', 'modified' ]
    \ }
\ }
function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

" ----> ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_types = ['mru', 'fil', 'buf']
let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
\ }

" ----> junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ----> plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1

" ----> majutsushi/tagbar
nmap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autofocus = 1
let g:tagbar_width = 40

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
\ 'ctagstype' : 'css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:headings',
    \ ],
    \ 'sort': 0
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
        \ 'v:FunctionVariables'
    \ ]
\ }

let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/path/to/your/universal/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

" ----> sheerun/vim-polyglot
let g:polyglot_disabled = ['go', 'python', 'rust']

" ----> ycm-core/youcompleteme
nmap <leader>yd :YcmDiags<CR>
augroup ycm
    autocmd!
    autocmd FileType c,cpp                                           nnoremap <leader>yi :YcmCompleter GoToInclude<CR>
    autocmd FileType c,cpp,go,java,javascript,python,rust,typescript nnoremap <leader>yl :YcmCompleter GoToDeclaration<CR>
    autocmd FileType c,cpp,go,java,javascript,python,rust,typescript nnoremap <leader>ye :YcmCompleter GoToDefinition<CR>
    autocmd FileType c,cpp,go,java,javascript,python,rust,typescript nnoremap <leader>yo :YcmCompleter GoTo<CR>
    autocmd FileType java,javascript,python,typescript               nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
    autocmd FileType javascript,typescript                           nnoremap <leader>yp :YcmCompleter GoToType<CR>
    autocmd FileType c,cpp,java,javascript,typescript                nnoremap <leader>yg :YcmCompleter GetType<CR>
    autocmd FileType c,cpp                                           nnoremap <leader>ya :YcmCompleter GetParent<CR>
    autocmd FileType c,cpp,java,javascript,python,rust,typescript    nnoremap <leader>yc :YcmCompleter GetDoc<CR>
    autocmd FileType c,cpp,java,javascript,typescript                nnoremap <leader>yf :YcmCompleter FixIt<CR>
augroup END
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'    "default ycm conf location
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '--'
let g:ycm_confirm_extra_conf = 0    "no annoying tips on vim starting
let g:ycm_show_diagnostics_ui = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
noremap <c-z> <NOP>
let g:ycm_use_ultisnips_completer = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_semantic_triggers = {'*': ['re![.:>\-\w]{2}']}

" ----> dense-analysis/ale
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_linters = {
    \ 'c': ['gcc', 'cppcheck'],
    \ 'cpp': ['gcc', 'cppcheck'],
    \ 'csh': ['shell'],
    \ 'elixir': ['credo', 'dialyxir', 'dogma'],
    \ 'go': ['gofmt', 'golint', 'go vet'],
    \ 'hack': ['hack'],
    \ 'lua': ['luac'],
    \ 'java': ['javac'],
    \ 'javascript': ['eslint'],
    \ 'perl': ['perlcritic'],
    \ 'python': ['flake8', 'mypy', 'pylint'],
    \ 'rust': ['cargo'],
    \ 'text': ['textlint', 'write-good', 'languagetool'],
    \ 'vue': ['eslint', 'vls'],
    \ 'zsh': ['shell']
\ }
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_fixers = {
    \ 'javascript': ['eslint'],
    \ 'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8'],
\ }
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_insert_leave = 1
" reduce the process priority of ale
if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
    let g:ale_command_wrapper = 'nice -n5'
endif
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear ALEInfoSign

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \ '%dW %dE',
        \ all_non_errors,
        \ all_errors
    \ )
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

" ----> rust-lang/rust.vim
let g:rustfmt_autosave = 1

" ============> Custom <============

" ----> GUI
if has('gui_running')
    set lines=25
    set columns=80
    set lazyredraw
    set guioptions-=m             " hide menu bar
    set guioptions-=T             " hode tool bar
    set guifont=consolas\ 10
    set guicursor=a:blinkon0      " disable cursor blink
endif

" ----> Color
set t_Co=256
set background=dark
if &term =~? '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    set t_ut=
endif

colorscheme molokai

" set colorcolumn=120     " column color

" ----> Keyboard
let mapleader = ','     " set vim map leader
let g:mapleader = ','

nnoremap <silent> <leader><space> :nohlsearch<cr>   " turn off search highlight
nnoremap <leader>sh :sh<cr>                         " hold vim and run a shell at this directory, exit will return vim

nnoremap <Leader>tc :tabc<CR>   " close current tab page
nnoremap <Leader>tn :tabn<CR>   " go to the next tab page
nnoremap <Leader>tp :tabp<CR>   " go to the previous tab page
nnoremap <Leader>te :tabe<CR>   " open a new tab page with an empty window

noremap <F2> :setlocal spell! spelllang=en_us<CR>   " set spell shortcut

cnoreabbrev W! w!   " easy exit vim
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

nnoremap j gj   " treat long lines as break lines
nnoremap k gk

nnoremap B ^    " move to beginning/end of line
nnoremap E $

nnoremap $ <nop>    " $/^ doesn't do anything
nnoremap ^ <nop>

nnoremap gV `[v`]   " highlight last inserted text

noremap gh <C-W>h
noremap gk <C-W>k
noremap gl <C-W>l
noremap gj <C-W>j
" noremap F gf

" ----> Highlights
" Highlight some special strings
highlight ToDo cterm=bold term=bold ctermbg=yellow ctermfg=black
match ToDo /\(TODO\)/
autocmd WinEnter * match ToDo /\(TODO\)/

" highlight WhiteSpaceEOL ctermbg=darkgreen guibg=lightgreen
" match WhiteSpaceEOL /\s$/
" autocmd WinEnter * match WhiteSpaceEOL /\s$/

" ----> Tricks
" Trim trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

" Terminal setting
if has('terminal') && exists(':terminal') == 2
    if exists('##TerminalOpen')
        augroup VimUnixTerminalGroup
            autocmd!
            autocmd TerminalOpen * setlocal nonumber signcolumn=no
        augroup END
    endif
endif

" Remember cursor position
augroup VimRememberCursorPosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" ----> Headers
function! s:PythonHeader()
    normal! i#!/usr/bin/env python
    normal! o# -*- coding: utf-8 -*-
    let fullname = ''
    if has('macunix')
        let fullname = split(system("finger `whoami` | awk -F: '{ print $3  }' | head -n1 | sed 's/^ //'"), '\n')[0]
    elseif has('unix')
        let fullname = split(system('whoami | head -n1'), '\n')[0]
    endif
    if fullname !=? ''
        let @o = '# by ' . fullname . ' ' . strftime('%Y-%m-%d %H:%M:%S')
        put o
    endif
    normal! o
endfunction

augroup PythonHeader
    autocmd!
    autocmd BufNewFile *.py call s:PythonHeader()
augroup END
