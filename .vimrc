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
let coc_cofig_exists=expand('~/.vim/coc-settings.json')
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if !filereadable(coc_cofig_exists) || !filereadable(vimplug_exists)
    if !executable('curl')
        echoerr 'You have to install curl or first install vim-plug yourself!'
        execute 'q!'
    endif
    if !filereadable(coc_cofig_exists)
        if !executable('yarn') && !executable('npm')
            echoerr 'You have to install yarn/npm for coc.nvim plugin later!'
            echo ''
        endif
        echo 'Download coc-settings.json...'
        echo ''
        silent !\curl -fLo ~/.vim/coc-settings.json --create-dirs https://tarrex.github.io/dotfiles/coc-settings.json
    endif
    if !filereadable(vimplug_exists)
        echo 'Installing Vim-Plug...'
        echo ''
        silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd! VimEnter * PlugInstall
    endif
endif

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for': 'go'}
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ----> fatih/vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "locationlist"
let g:go_addtags_transform = 'camelcase'
let g:go_def_reuse_buffer = 1
let g:go_def_mapping_enabled = 0
let g:go_decls_mode = 'ctrlp.vim'
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1

" Open :GoDeclsDir with ctrl-g
nmap <c-g> :GoDeclsDir<cr>
imap <c-g> <esc>:<c-u>GoDeclsDir<cr>

augroup go
    autocmd!
    " :GoBuild and :GoTestCompile
    autocmd FileType go nmap <leader>b :<c-u>call <SID>build_go_files()<cr>
    " :GoTest
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go nmap <leader>tf  <Plug>(go-test-func)
    " :GoRun
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    " :GoDoc
    autocmd FileType go nmap <leader>d <Plug>(go-doc)
    " :GoCoverageToggle
    autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
    " :GoInfo
    autocmd FileType go nmap <leader>i <Plug>(go-info)
    " :GoMetaLinter
    autocmd FileType go nmap <leader>l <Plug>(go-metalinter)
    " :GoDef but opens in a vertical split
    autocmd FileType go nmap <leader>v <Plug>(go-def-vertical)
    " :GoDef but opens in a horizontal split
    autocmd FileType go nmap <leader>s <Plug>(go-def-split)
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
nnoremap <silent> <F3> :NERDTreeToggle<cr>

" ----> itchyny/lightline.vim
" set showtabline=2  " show tabline
let g:lightline = {
    \ 'enable': {
    \   'statusline': 1,
    \   'tabline': 1
    \ },
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'buffernum' ],
    \           [ 'gitbranch', 'venv', 'readonly', 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'linter', 'fileformat', 'fileencoding', 'filetype' ],
    \            [ 'tagbar' ],
    \            [ 'blame' ] ]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'linter': 'LightlineLinter',
    \   'venv': 'virtualenv#statusline',
    \   'gitbranch': 'LightlineGitBranch',
    \   'blame': 'LightlineGitBlame'
    \ },
    \ 'tabline': {
    \   'left': [ [ 'tabs' ] ],
    \   'right': []
    \ },
    \ 'tab': {
    \   'active': [ 'filename', 'modified' ],
    \   'inactive': [ 'filename', 'modified' ]
    \ },
    \ 'component': {
    \   'buffernum': '%n',
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}'
    \ }
\ }

function! LightlineFilename()
    let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

function! LightlineLinter() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \ '%dW %dE',
        \ all_non_errors,
        \ all_errors
    \ )
endfunction

function! LightlineGitBranch() abort
    let branch = get(g:, 'coc_git_status', '')
    return branch
endfunction

function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    " return blame
    return winwidth(0) > 120 ? blame : ''
endfunction

" ----> ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_types = ['buf', 'mru', 'fil']
let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
\ }

" ----> junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ----> majutsushi/tagbar
nmap <silent> <F8> :TagbarToggle<cr>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autofocus = 1
let g:tagbar_width = 40

let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds': [
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
    \ 'sro': '.',
    \ 'kind2scope': {
        \ 't': 'ctype',
        \ 'n': 'ntype'
    \ },
    \ 'scope2kind': {
        \ 'ctype': 't',
        \ 'ntype': 'n'
    \ },
    \ 'ctagsbin': 'gotags',
    \ 'ctagsargs': '-sort -silent'
\ }

let g:tagbar_type_css = {
\ 'ctagstype': 'css',
    \ 'kinds': [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'kinds': [
        \ 'h:headings',
    \ ],
    \ 'sort': 0
\ }

let g:tagbar_type_make = {
    \ 'ctagstype': 'make',
    \ 'kinds': [
        \ 'm:macros',
        \ 't:targets'
    \ ]
\ }

let g:tagbar_type_r = {
    \ 'ctagstype': 'r',
    \ 'kinds': [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables'
    \ ]
\ }

let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
  \ 'ctagstype': 'rust',
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

" ----> rust-lang/rust.vim
let g:rustfmt_autosave = 1

" ----> neoclide/coc.nvim
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-dictionary',
    \ 'coc-word',
    \ 'coc-emoji',
    \ 'coc-python',
    \ 'coc-java',
    \ 'coc-syntax',
    \ 'coc-rls',
    \ 'coc-git'
\]

highlight clear CocErrorSign
highlight clear CocWarningSign
highlight clear CocInfoSign

" Use <tab> and <s-tab> to navigate the completion list
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<c-g>u\<cr>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<cr>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <c-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <c-d> <Plug>(coc-range-select)
xmap <silent> <c-d> <Plug>(coc-range-select)

" Using CocList
nnoremap <silent> <space>a  :<c-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<c-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<c-u>CocList commands<cr>
nnoremap <silent> <space>o  :<c-u>CocList -A outline<cr>
nnoremap <silent> <space>s  :<c-u>CocList -I -N symbols<cr>
nnoremap <silent> <space>j  :<c-u>CocNext<cr>
nnoremap <silent> <space>k  :<c-u>CocPrev<cr>
nnoremap <silent> <space>p  :<c-u>CocListResume<cr>

" ----> dense-analysis/ale
let g:ale_disable_lsp = 1
let g:ale_maximum_file_size = 2 * 1024 * 1024
let g:ale_linters_explicit = 1
let g:ale_command_wrapper = 'nice -n5 %*'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {
    \ 'c': ['gcc'],
    \ 'cpp': ['gcc'],
    \ 'go': ['gofmt', 'golint', 'govet'],
    \ 'java': ['javac'],
    \ 'lua': ['luac'],
    \ 'rust': ['cargo'],
    \ 'sh': ['shell']
\ }
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_linter_aliases = {
    \ 'Dockerfile': 'dockerfile',
    \ 'vimwiki': 'markdown',
    \ 'zsh': 'sh'
\ }
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'go': ['gofmt']
\}
let g:ale_fix_on_save = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_info = '~~'
let g:ale_echo_msg_format = '%severity%: [%linter%] %s'
let g:ale_loclist_msg_format = '[%linter%] %s'
let g:ale_list_window_size = 5
let g:ale_open_list = 'on_save'

augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

nmap <silent> <c-k> <Plug>(ale_previous_wrap)
nmap <silent> <c-j> <Plug>(ale_next_wrap)

highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear ALEInfoSign
highlight clear ALEStyleErrorSign
highlight clear ALEStyleWarningSign

" ============> Custom <============

" ----> Color
if &term =~? '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

set t_8f=^[[38;2;%lu;%lu;%lum   " set foreground color
set t_8b=^[[48;2;%lu;%lu;%lum   " set background color
set t_Co=256                    " enable 256 colors

if has('termguicolors')
    set termguicolors   " enable GUI colors for the terminal to get truecolor
endif

set background=dark

colorscheme molokai

" set colorcolumn=120   " column color

" ----> Keyboard
let mapleader = ','     " set vim map leader
let g:mapleader = ','

nnoremap <silent> <leader>n :nohlsearch<cr> " turn off search highlight
nnoremap <leader>sh :sh<cr>                 " hold vim and run a shell at this directory, exit will return vim

nnoremap <leader>tc :tabc<cr>   " close current tab page
nnoremap <leader>tn :tabn<cr>   " go to the next tab page
nnoremap <leader>tp :tabp<cr>   " go to the previous tab page
nnoremap <leader>te :tabe<cr>   " open a new tab page with an empty window

noremap <F2> :setlocal spell! spelllang=en_us<cr>   " set spell shortcut

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

nnoremap B ^        " move to beginning/end of line
nnoremap E $
nnoremap $ <nop>    " $/^ doesn't do anything
nnoremap ^ <nop>

nnoremap gV `[v`]   " highlight last inserted text

noremap gh <c-w>h
noremap gk <c-w>k
noremap gl <c-w>l
noremap gj <c-w>j
" noremap F gf

" ----> Highlights
" Highlight some special strings
highlight ToDo cterm=bold term=bold ctermbg=yellow ctermfg=black
match ToDo /\(TODO\)/
augroup HilightSpecialStrings
    autocmd!
    autocmd WinEnter * match ToDo /\(TODO\)/
augroup END

" highlight WhiteSpaceEOL ctermbg=darkgreen guibg=lightgreen
" match WhiteSpaceEOL /\s$/
" augroup HilightSpecialStrings
"     autocmd WinEnter * match WhiteSpaceEOL /\s$/
" augroup END

" ----> Tricks
" Trim trailing whitespace on write
autocmd! BufWritePre * :%s/\s\+$//e

" Terminal setting
if has('terminal') && exists(':terminal') == 2
    if exists('##TerminalOpen')
        autocmd! TerminalOpen * setlocal nonumber signcolumn=no
    endif
endif

" Remember cursor position
autocmd! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" ----> Headers
augroup AddHeaderForNewFile
    autocmd!
    autocmd BufNewFile *.py call s:PythonHeader()
augroup END

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
