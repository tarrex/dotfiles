" Tarrex's vimrc
"       ------ Enjoy vim, enjoy coding.

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
set ttyfast

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

" set cursorline                " show underline for the cursor's line
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

set modelines=0

set scrolloff=1

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

Plug 'chriskempson/base16-vim'
" Plug 'vim-scripts/ScrollColors'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries', 'for': 'go'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}

call plug#end()

" ----> fatih/vim-go
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_autodetect_gopath = 1
let g:go_fmt_autosave = 0
let g:go_fmt_command = 'goimports'
let g:go_list_type = "locationlist"
let g:go_addtags_transform = 'camelcase'
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1
if has('nvim')
    let g:go_term_enabled = 1
    let g:go_term_mode = 'split'
    let g:go_term_height = 10
endif

augroup Go
    autocmd!
    autocmd FileType go nmap <c-g> :GoDeclsDir<cr>
    autocmd FileType go imap <c-g> <esc>:<c-u>GoDeclsDir<cr>
    autocmd FileType go nmap <leader>gb :<c-u>call <SID>build_go_files()<cr>
    autocmd FileType go nmap <leader>gt <Plug>(go-test)
    autocmd FileType go nmap <leader>gf <Plug>(go-test-func)
    autocmd FileType go nmap <leader>gr <Plug>(go-run)
    autocmd FileType go nmap <leader>gh <Plug>(go-doc)
    autocmd FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <leader>gi <Plug>(go-info)
    autocmd FileType go nmap <leader>gd <Plug>(go-def-split)
    autocmd FileType go nmap <leader>gm <Plug>(go-rename)
    autocmd FileType go nmap <leader>ge <Plug>(go-iferr)
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files() abort
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

" ----> itchyny/lightline.vim
" set showtabline=2  " show tabline
let g:lightline = {
    \ 'enable': {
    \   'statusline': 1,
    \   'tabline': 1
    \ },
    \ 'colorscheme': 'materia',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'buffernum' ],
    \           [ 'gitbranch', 'readonly', 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'linter', 'fileformat', 'fileencoding', 'filetype' ],
    \            [ 'tagbar' ],
    \            [ 'blame' ] ]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'linter': 'LightlineLinter',
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

function! LightlineFilename() abort
    let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

function! LightlineLinter() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
        let msgs = []
        if get(info, 'error', 0)
            call add(msgs, 'E' . info['error'])
        endif
    if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

function! LightlineGitBranch() abort
    let branch = get(g:, 'coc_git_status', '')
    return len(branch) > 14 ? branch[0:14] . '...' : branch
endfunction

function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    if winwidth(0) > 120 && len(blame) > 0
        return split(blame, ')')[0] . ')'
    else
        return ''
    endif
endfunction

" ----> easymotion/vim-easymotion
let g:EasyMotion_smartcase = 1

" ----> ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_types = ['fil', 'mru', 'buf']
let g:ctrlp_root_markers = ['.svn', '.git', '.projections.json', '.travis.yml', 'Cargo.toml', 'go.mod']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
\ }
if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

" ----> majutsushi/tagbar
nmap <silent> <F8> :TagbarToggle<cr>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autofocus = 1
let g:tagbar_width = 40

let g:tagbar_type_make = {
    \ 'ctagstype': 'make',
    \ 'kinds': [
        \ 'm:macros',
        \ 't:targets'
    \ ]
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'kinds': [
        \ 'h:headings',
    \ ],
    \ 'sort': 0
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
    \ 'coc-git',
    \ 'coc-vimlsp'
\]

highlight clear CocErrorSign
highlight clear CocWarningSign
highlight clear CocInfoSign
highlight clear CocHintSign

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <tab>
    \ pumvisible() ? "\<c-n>" :
    \ <SID>check_back_space() ? "\<tab>" :
    \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<c-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<c-y>" : "\<c-g>u\<cr>"
else
    imap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup CocFormat
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <tab> <Plug>(coc-range-select)
xmap <silent> <tab> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<c-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<c-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<c-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<c-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<c-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<c-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent> <space>k  :<c-u>CocPrev<cr>
" Resume latest coc list.
nnoremap <silent> <space>p  :<c-u>CocListResume<cr>

" ============> Custom <============

" ----> Color
if &term =~? '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

set t_Co=256            " enable 256 colors

if has('termguicolors')
    set termguicolors   " enable GUI colors for the terminal to get truecolor
endif

set background=dark

colorscheme base16-materia
highlight Normal guibg=black ctermbg=black
highlight LineNr guibg=black ctermbg=black

" ----> Keyboard
let mapleader = ','     " set vim map leader
let g:mapleader = ','

nnoremap <silent> <leader>n :nohlsearch<cr> " turn off search highlight
nnoremap <leader>sh :sh<cr>                 " hold vim and run a shell at this directory, exit will return vim

nnoremap <leader>tc :tabclose<cr>           " close tab
nnoremap <leader>tn :tabnext<cr>            " go to next tab
nnoremap <leader>tp :tabprevious<cr>        " go to previous tab
nnoremap <leader>te :tabnew<cr>             " create new tab

nnoremap <leader>bp :bprevious<cr>          " go to previous buffer
nnoremap <leader>bn :bnext<cr>              " go to next buffer
nnoremap <leader>bd :bdelete<cr>            " close the current buffer
nnoremap <leader>bl :buffers<cr>            " list buffers
nnoremap <leader>bg :buffer                 " go to given buffer number

nnoremap <F2> :setlocal spell! spelllang=en_us<cr>   " set spell shortcut

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

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

noremap gh <c-w>h
noremap gk <c-w>k
noremap gl <c-w>l
noremap gj <c-w>j
" noremap F gf

" Search will center on the line it's found in
nnoremap n nzzzv
nnoremap N Nzzzv

" Move visual block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Move vertically by visual line
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap <leader>tm :terminal<cr><c-w>L

" Hex read
nmap <leader>hr :%!xxd<cr> :set filetype=xxd<cr>
" Hex write
nmap <leader>hw :%!xxd -r<cr> :set binary<cr> :set filetype=<cr>

" Map w!! to write file with sudo
cmap w!! w !sudo tee % >/dev/null

" Toggle displaying non-printable characters
nnoremap <leader>ls :set list!<cr>

" Toggle soft-wrap
nnoremap <leader>wr :set wrap! wrap?<cr>

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
" Switch to working directory of the open file
autocmd! BufEnter * lcd %:p:h

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

" Close the locationlist window when exiting
autocmd! QuitPre * if empty(&buftype) | lclose | endif

" Shebang
augroup ShebangForNewFile
    autocmd!
    autocmd BufNewFile *.sh  0put =\"#!/usr/bin/env bash\<nl>\<nl>\"|$
    autocmd BufNewFile *.erl 0put =\"#!/usr/bin/env escript\<nl>\<nl>\"|$
    autocmd BufNewFile *.js  0put =\"#!/usr/bin/env node\<nl>\<nl>\"|$
    autocmd BufNewFile *.lua 0put =\"#!/usr/bin/env lua\<nl>\<nl>\"|$
    autocmd BufNewFile *.rb  0put =\"#!/usr/bin/env ruby\<nl>\<nl>\"|$
    autocmd BufNewFile *.pl  0put =\"#!/usr/bin/env perl\<nl>\<nl>\"|$
    autocmd BufNewFile *.php 0put =\"#!/usr/bin/env php\<nl>\<nl>\"|$
    autocmd BufNewFile *.py  0put =\"#!/usr/bin/env python3\<nl>\<nl>\"|$
    autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
augroup END

" ----> Netrw
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_list_hide = &wildignore
function! ToggleNetrw() abort
    let i = bufnr("$")
    let wasOpen = 0
    while (i >= 1)
        if (getbufvar(i, "&filetype") == "netrw")
            silent exe "bwipeout " . i
            let wasOpen = 1
        endif
        let i-=1
    endwhile
    if !wasOpen
        silent Lexplore
    endif
endfunction
noremap <silent> <F3> :call ToggleNetrw()<cr>

" ----> Zen mode
let s:hidden_all=0
function! ToggleHideAll() abort
    if s:hidden_all==0
        let s:hidden_all=1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set nonumber
        syntax off
    else
        let s:hidden_all=0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set number
        syntax on
    endif
endfunction
nnoremap <silent> <leader>h :call ToggleHideAll()<cr>

" ----> View changes after the last save
function! s:DiffWithSaved() abort
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    exe "normal! ]c"
endfunction
command! DiffSaved call s:DiffWithSaved()
nnoremap <leader>? :DiffSaved<cr>

" ----> Toggle Quickfix / Location window
let g:list_height = 5
let g:quickfix_open = 0
function! QuickfixToggle() abort
    if g:quickfix_open
        silent! cclose
        let g:quickfix_open = 0
        execute g:quickfix_return . 'wincmd w'
    else
        let g:quickfix_return = winnr()
        execute 'silent! copen ' . g:list_height
        let g:quickfix_open = 1
    endif
endfunction
nnoremap <leader>q :call QuickfixToggle()<cr>

let g:location_open = 0
function! LocationToggle() abort
    if g:location_open
        silent! lclose
        let g:location_open = 0
        execute g:location_return . 'wincmd w'
    else
        let g:location_return = winnr()
        execute 'silent! lopen ' . g:list_height
        let g:location_open = 1
    endif
endfunction
nnoremap <leader>l :call LocationToggle()<cr>
