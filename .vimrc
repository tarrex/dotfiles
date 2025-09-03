" Tarrex's vimrc
"       ------ Enjoy vim, enjoy coding.

" ============> General <============
if &compatible | set nocompatible | endif

syntax on
filetype indent plugin on

set number
set noruler
set nowrap
set showcmd
set noshowmode
set laststatus=2
set display=lastline
set cursorline
silent! set cursorlineopt=number
silent! set signcolumn=number
silent! set termguicolors
set background=dark
set visualbell t_vb=

set shiftround
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
set smarttab
set autoindent

set breakindent
silent! set showbreak=↪\

set hlsearch
set ignorecase
set incsearch
set smartcase

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,latin1
set fileformats=unix,dos,mac

set autoread
set autowrite
set backspace=indent,eol,start
set nostartofline
set nojoinspaces
set hidden
set splitbelow
set splitright
set clipboard=unnamed,unnamedplus
set mouse=a
set t_ut=
set ttyscroll=3
set scrolloff=1
set sidescroll=5
set sidescrolloff=1

set history=1000

set include=
set completeopt=menu,menuone
silent! set completeopt+=noinsert
silent! set completeopt+=noselect
silent! set completeopt+=popup
silent! set completepopup=border:off
set diffopt+=context:3
set diffopt+=vertical
set diffopt+=foldcolumn:1
silent! set diffopt+=hiddenoff
silent! set diffopt+=indent-heuristic
silent! set diffopt+=algorithm:histogram
set formatoptions-=cro
set formatoptions+=mB
set shortmess=aoOcFtT
silent! set spelloptions=camel
set fillchars=vert:┃
set listchars=eol:¬
set listchars+=tab:\|\
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=nbsp:∅
set virtualedit=block
set whichwrap=b,s,h,l,<,>,[,]
set matchpairs+=<:>,《:》,「:」,（:）,【:】

let &directory = expand('~/.vim/tmp/swap')
if !isdirectory(&directory)
    call mkdir(&directory, 'p', 0700)
endif
set undofile
let &undodir = expand('~/.vim/tmp/undo')
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
endif

set wildmenu
set wildignorecase
set wildignore+=*~,*.o,*.obj,*.out,*.so,*.egg,*.py[cdo],*.class,*.jar
set wildignore+=*.app,*.dll,*.dylib,*.elf,*.lib,*.map,*.gem,*.jar,*.swp,*.war
set wildignore+=*.7z,*.bz2,*.bzip,*.bzip2,*.cab,*.deb,*.dmg,*.gz,*.gzip
set wildignore+=*.iso,*.lzma,*.msi,*.rar,*.rpm,*.tar,*.tgz,*.xz,*.zip
set wildignore+=*.bmp,*.gif,*.ico,*.jpeg,*.jpg,*.png,*.tiff,*.webp,*.pdf
set wildignore+=*.aac,*.ape,*.avi,*.flac,*.flv,*.mkv,*.mp3,*.mp4,*.webm
set wildignore+=._*,.DS_Store,.fseventsd,.Spotlight-V100,.Trashes
set wildignore+=[Dd]esktop.ini,*.lnk,\$RECYCLE.BIN/*,*.stackdump,Thumbs.db
set wildignore+=.git/*,.github/*,.hg/*,.idea/*,.svn/*,.vscode/*
set wildignore+=**/.git/**,**/.github/**,**/.hg/**,**/.idea/**,**/.svn/**,**/.vscode/**
set wildignore+=**/node_modules/**,**/dist/**,**/build/**,**/target/**
set wildignore+=**/__pycache__/**,**/.cache/**,**/coverage/**

set t_RV=

" ============> Plugins <============
let s:vimplug = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:vimplug))
    if !executable('curl')
        echomsg 'You have to install curl or install vim-plug manually!'
        finish
    endif
    silent execute '!echo "Installing Vim-Plug..."'
    silent execute '!curl --compressed --create-dirs --progress-bar -fLo ' . s:vimplug .
                 \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand('~/.vim/plugged'))

Plug 'lifepillar/vim-gruvbox8'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'chrisbra/colorizer', { 'on': 'ColorToggle' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'raimondi/delimitmate'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' }
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'dense-analysis/ale'
" Plug 'fatih/vim-go',               { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'tpope/vim-markdown',         { 'for': 'markdown' }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown', 'on': 'TableModeToggle' }
Plug 'tarrex/nginx.vim',           { 'for': 'nginx' }
Plug 'mtdl9/vim-log-highlighting', { 'for': 'log' }
" Plug 'wakatime/vim-wakatime'
" Plug 'tweekmonster/startuptime.vim'
" Plug 'dstein64/vim-startuptime'

call plug#end()

function! HasPlug(name) abort
    return has_key(g:plugs, a:name) ? isdirectory(g:plugs[a:name].dir) : 0
endfunction

" ----> itchyny/lightline.vim
if HasPlug('lightline.vim')
    let g:lightline = {
        \ 'enable': {
        \   'statusline': 1,
        \   'tabline': 1
        \ },
        \ 'colorscheme': 'gruvbox8',
        \ 'separator': {'left': '', 'right': '' },
        \ 'subseparator': { 'left': '⎢', 'right': '⎥' },
        \ 'active': {
        \   'left': [[ 'mode', 'paste', 'spell' ],
        \           [ 'bufnum' ],
        \           [ 'readonly', 'filename' ]],
        \   'right': [[ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'linter', 'filesize', 'fileformat', 'fileencoding', 'filetype' ]]
        \ },
        \ 'inactive': {
        \   'left': [[ 'mode' ],
        \           [ 'bufnum' ],
        \           [ 'filename' ]],
        \   'right': [[ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'filetype' ]]
        \ },
        \ 'component_function': {
        \   'mode':         'LightLineMode',
        \   'readonly':     'LightLineReadOnly',
        \   'filename':     'LightlineFilename',
        \   'linter':       'LightlineLinter',
        \   'filesize':     'LightlineFileSize',
        \   'fileformat':   'LightLineFileFormat',
        \   'fileencoding': 'LightLineFileEncoding',
        \   'filetype':     'LightLineFileType'
        \ }
    \ }

    let s:fts = ['qf', 'help', 'man', 'vista']

    function! LightLineMode() abort
        return (&ft ==? 'qf' && getwininfo(win_getid())[0].loclist) ? 'LocList' :
            \ &ft ==? 'qf' ? 'QuickFix' :
            \ index(s:fts, &ft) >= 0 ? substitute(&ft, '\v<(.)', '\u\1', '') :
            \ lightline#mode()
    endfunction

    function! LightLineReadOnly() abort
        return &readonly && &filetype !~# '\v(help)' ? 'RO' : ''
    endfunction

    function! LightlineFilename() abort
        if mode() == 't' | return expand('%') | endif
        if winwidth(0) < 50
            let fname = expand('%:t')
        elseif winwidth(0) > 150
            let fname = expand('%')
        else
            let fname = pathshorten(expand('%'))
        endif
        return index(s:fts, &ft) >= 0 ? '' :
            \ ('' !=? fname ? fname : '[No Name]') .
            \ (&modified ? ' +' : '')
    endfunction

    function! LightlineLinter() abort
        if (winwidth(0) < 80 || mode() == 't') | return '' | endif
        if HasPlug('ale')
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : printf(
                \ ' %d  %d',
                \ all_non_errors,
                \ all_errors
            \ )
        endif
        return ''
    endfunction

    function! LightlineFileSize() abort
        if (winwidth(0) < 70 || mode() == 't') | return '' | endif
        let l:bytes = getfsize(@%)
        if l:bytes < 0 | return '' | endif
        let l:units = ['B', 'K', 'M', 'G']
        let l:idx = 0
        while l:bytes >= 1024
            let l:bytes = l:bytes / 1024.0
            let l:idx += 1
        endwhile
        return index(s:fts, &ft) >= 0 ? ''
            \ : printf('%.1f%s', l:bytes, l:units[l:idx])
    endfunction

    function! LightLineFileFormat() abort
        if (winwidth(0) < 60 || mode() == 't') | return '' | endif
        return index(s:fts, &ft) >= 0 ? ''
            \ : &fileformat
    endfunction

    function! LightLineFileEncoding() abort
        if (winwidth(0) < 50 || mode() == 't') | return '' | endif
        return index(s:fts, &ft) >= 0 ? '' :
            \ &fenc !=# '' ? &fenc : &enc
    endfunction

    function! LightLineFileType() abort
        if (winwidth(0) < 40 || mode() == 't') | return '' | endif
        return index(s:fts, &ft) >= 0 ? '' :
            \ &ft !=# '' ? &ft : 'no ft'
    endfunction
endif

" ----> easymotion/vim-easymotion
if HasPlug('vim-easymotion')
    let g:EasyMotion_do_mapping       = 0
    let g:EasyMotion_grouping         = 1
    let g:EasyMotion_smartcase        = 1
    let g:EasyMotion_startofline      = 0
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_space_jump_first = 1

    nnoremap <em> <nop>
    nmap     J    <em>

    nmap <em>s <Plug>(easymotion-s2)
    xmap <em>s <Plug>(easymotion-s2)
    nmap <em>/ <Plug>(easymotion-sn)
    xmap <em>/ <Plug>(easymotion-sn)
    nmap <em>l <Plug>(easymotion-overwin-line)
    xmap <em>l <Plug>(easymotion-bd-jk)
    omap <em>l <Plug>(easymotion-bd-jk)
    nmap <em>w <Plug>(easymotion-overwin-w)
    xmap <em>w <Plug>(easymotion-bd-w)
    omap <em>w <Plug>(easymotion-bd-w)
endif

" ----> junegunn/fzf.vim
if HasPlug('fzf.vim')
    let g:fzf_command_prefix = 'FZF'
    let g:fzf_layout         = { 'window': { 'width': 0.9, 'height': 0.8 } }
    function! s:build_quickfix_list(lines)
        call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
        copen
        cc
    endfunction
    let g:fzf_action = {
        \ 'ctrl-q': function('s:build_quickfix_list'),
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit',
        \ 'ctrl-e': 'edit'
    \ }
    let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!{".&wildignore."}'"
    endif
    command! -bang -nargs=* FZFRg
        \ call fzf#vim#grep(
        \   "rg --column --line-number --no-heading --color=always --smart-case " .
        \   "--hidden --glob '!{".&wildignore."}' -- ".shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(), <bang>0)
    command! -bang -nargs=* FZFGGrep
        \ call fzf#vim#grep(
        \   'git grep --line-number -- '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

    nnoremap <silent> <space>fb  :FZFBuffers<cr>
    nnoremap <silent> <space>fc  :FZFBCommits<cr>
    nnoremap <silent> <space>ff  :FZFFiles<cr>
    nnoremap <silent> <space>fg  :FZFGFiles?<cr>
    nnoremap <silent> <space>fh  :FZFHelptags<cr>
    nnoremap <silent> <space>fm  :FZFMaps<cr>
    nnoremap <silent> <space>fr  :FZFRg<cr>
    nnoremap <silent> <space>ft  :FZFBTags<cr>

    command! -bar -bang FZFMapsI call fzf#vim#maps("i", <bang>0)
    command! -bar -bang FZFMapsN call fzf#vim#maps("n", <bang>0)
    command! -bar -bang FZFMapsO call fzf#vim#maps("o", <bang>0)
    command! -bar -bang FZFMapsV call fzf#vim#maps("v", <bang>0)
    command! -bar -bang FZFMapsX call fzf#vim#maps("x", <bang>0)
endif

" ----> mbbill/undotree
if HasPlug('undotree')
    nnoremap <silent> <localleader>u :UndotreeToggle<cr>
endif

" ----> raimondi/delimitmate
if HasPlug('delimitmate')
    let delimitMate_offByDefault = 0
    let delimitMate_expand_cr = 1
    let delimitMate_expand_space = 1
endif

" ----> editorconfig/editorconfig-vim
if HasPlug('editorconfig-vim')
    let g:EditorConfig_disable_rules    = ['trim_trailing_whitespace']
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    augroup EditorConfig
        autocmd!
        autocmd FileType gitcommit let b:EditorConfig_disable = 1
    augroup END
endif

" ----> liuchengxu/vista.vim
if HasPlug('vista.vim')
    let g:vista_sidebar_position         = 'vertical botright'
    let g:vista_sidebar_width            = 30
    let g:vista_echo_cursor              = 1
    let g:vista_cursor_delay             = 400
    if has('patch-8.2.0750')
        let g:vista_echo_cursor_strategy = 'floating_win'
    endif
    let g:vista_close_on_jump            = 0
    let g:vista_fzf_preview              = ['right:50%']
    let g:vista_disable_statusline       = 1
    let g:vista#renderer#enable_icon     = 0

    nnoremap <silent> <localleader>t :Vista vim_lsp<cr>
endif

" ----> prabirshrestha/vim-lsp
if HasPlug('vim-lsp')
    let g:lsp_use_native_client = 1
    let g:lsp_diagnostics_float_cursor = 1
    let g:lsp_diagnostics_signs_enabled = 0
    let g:lsp_diagnostics_signs_insert_mode_enabled = 0
    let g:lsp_hover_conceal = 0
    " inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr
    inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ asyncomplete#force_refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
endif

" ----> dense-analysis/ale
if HasPlug('ale')
    let g:ale_command_wrapper            = 'nice -n5'
    let g:ale_maximum_file_size          = 10 * 1024 * 1024
    let g:ale_disable_lsp                = 1
    let g:ale_echo_cursor                = 0
    " let g:ale_echo_msg_error_str         = 'E'
    " let g:ale_echo_msg_info_str          = 'I'
    " let g:ale_echo_msg_warning_str       = 'W'
    " let g:ale_echo_msg_log_str           = 'L'
    " let g:ale_echo_msg_format            = '%severity%: [%linter%] %s'
    let g:ale_cursor_detail              = 1
    let g:ale_floating_preview           = 1
    let g:ale_floating_window_border     = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
    let g:ale_hover_cursor               = 0
    let g:ale_hover_to_floating_preview  = 0
    let g:ale_set_loclist                = 0
    let g:ale_set_quickfix               = 1
    let g:ale_loclist_msg_format         = '[%linter%] %code: %%s'
    let g:ale_open_list                  = 9999
    let g:ale_sign_error                 = ' '
    let g:ale_sign_warning               = ' '
    let g:ale_sign_info                  = ' '
    let g:ale_virtualtext_cursor         = 0
    let g:ale_fix_on_save                = 1
    let g:ale_fixers = {
        \ 'c':        ['clang-format'],
        \ 'cpp':      ['clang-format'],
        \ 'go':       ['goimports', 'gofmt'],
        \ 'markdown': ['pandoc'],
        \ 'python':   ['black', 'isort', 'yapf'],
        \ 'rust':     ['rustfmt'],
    \}
    let g:ale_c_clangformat_style_option = '{BasedOnStyle: LLVM, IndentWidth: 4}'
    let g:ale_lint_on_enter              = 0
    let g:ale_lint_on_save               = 1
    let g:ale_lint_on_text_changed       = 'normal'
    let g:ale_lint_on_insert_leave       = 1
    let g:ale_linters_explicit           = 1
    let g:ale_linters = {
        \ 'c':        ['cc', 'clangd', 'cppcheck'],
        \ 'cpp':      ['cc', 'clangd', 'cppcheck'],
        \ 'go':       ['gobuild', 'govet', 'gopls'],
        \ 'java':     ['javac'],
        \ 'markdown': ['scpell'],
        \ 'python':   ['flake8', 'pylint', 'pyright'],
        \ 'rust':     ['rustc', 'cargo', 'analyzer'],
        \ 'sh':       ['shell'],
    \ }

    nmap <silent> [a <Plug>(ale_previous)
    nmap <silent> ]a <Plug>(ale_next)
    nmap <silent> [A <Plug>(ale_first)
    nmap <silent> ]A <Plug>(ale_last)
    nmap <silent> ff <Plug>(ale_fix)
endif

" ----> fatih/vim-go
if HasPlug('vim-go')
    let g:go_version_warning            = 0
    let g:go_code_completion_enabled    = 0
    let g:go_test_show_name             = 0
    let g:go_play_open_browser          = 0
    let g:go_jump_to_error              = 0
    let g:go_fmt_autosave               = 0
    let g:go_imports_autosave           = 0
    let g:go_mod_fmt_autosave           = 0
    let g:go_doc_keywordprg_enabled     = 0
    if has('patch-8.2.0012')
        let g:go_doc_popup_window       = 1
    endif
    let g:go_def_mapping_enabled        = 0
    let g:go_textobj_enabled            = 0
    let g:go_alternate_mode             = 'vsplit'
    let g:go_gopls_enabled              = 0
    let g:go_template_autocreate        = 0
    let g:go_echo_command_info          = 0
    let g:go_echo_go_info               = 0
    let g:go_addtags_transform          = 'camelcase'
    let g:go_debug_windows              = {
        \ 'vars': 'leftabove 30vnew',
        \ 'stack': 'botright 20new',
        \ 'goroutines': 'rightbelow 10new',
    \ }
    let g:go_debug_mappings = {
        \ '(go-debug-continue)':   {'key': 'c', 'arguments': '<nowait>'},
        \ '(go-debug-stop)':       {'key': 'q'},
        \ '(go-debug-next)':       {'key': 'n', 'arguments': '<nowait>'},
        \ '(go-debug-step)':       {'key': 's'},
        \ '(go-debug-breakpoint)': {'key': 'b'},
        \ '(go-debug-print)':      {'key': 'p'},
        \ '(go-debug-halt)':       {'key': 'h'},
    \}
    let g:go_debug_address              = '127.0.0.1:8181'
    let g:go_debug_log_output           = 'debugger'
    let g:go_highlight_debug            = 1
    let g:go_debug_breakpoint_sign_text = '⬤'

    augroup Go
        autocmd!
        " :GoDoc work properly
        autocmd FileType go setlocal iskeyword+=.
        " key maps for go
        autocmd FileType go nmap <space>k  :GoDoc <c-r>=expand('<cword>')<cr><cr>
        autocmd FileType go nmap <c-g>     :GoDeclsDir<cr>
        autocmd FileType go imap <c-g>     <esc>:<c-u>GoDeclsDir<cr>
        autocmd FileType go nmap <space>gr :GoRun<cr>
        autocmd FileType go nmap <space>gt :GoTestFunc<cr>
        autocmd FileType go nmap <space>gc :GoCovergeToggle!<cr>
        autocmd FileType go nmap <space>gl :GoChannelPeers<cr>
        autocmd FileType go nmap <space>gs :GoSameIdsToggle<cr>
        autocmd FileType go nmap <space>gn :GoAlternate!<cr>
        autocmd FileType go nmap <space>gp :GoPointsTo<cr>
        autocmd FileType go nmap <space>gi :GoImpl<space>
        autocmd FileType go nmap <space>ga :GoAddTags<space>
        autocmd FileType go nmap <space>gz :GoRemoveTags<space>
        autocmd FileType go nmap <space>gk :GoKeyify<cr>
        autocmd FileType go nmap <space>gf :GoFillStruct<cr>
        autocmd FileType go nmap <space>ge :GoIfErr<cr>
        autocmd FileType go nmap <space>gd :GoDebugStart<cr>
        autocmd FileType go nmap <space>gb :GoDebugBreakpoint<cr>
        autocmd FileType go nmap <space>gq :GoDebugStop<cr>
    augroup END
endif

" ----> tpope/vim-markdown
if HasPlug('vim-markdown')
    let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'go']
    let g:markdown_syntax_conceal   = 1
    let g:markdown_minlines         = 100
endif

" ----> dhruvasagar/vim-table-mode
if HasPlug('vim-table-mode')
    let g:table_mode_corner = '|'
endif

" ============> key mappings <============
let g:mapleader      = ','  " set vim map leader, <leader>
let g:maplocalleader = '\'  " set vim local map leader, <localleader>

" Disable Ex mode and command history key bindings
nnoremap Q  <nop>
nnoremap q: <nop>

" Toggle number,paste,cuc,list,wrap,spell and so on.
nnoremap <silent> <localleader>n :setl number! nu?<cr>
nnoremap <silent> <localleader>r :setl relativenumber! rnu?<cr>
nnoremap <silent> <localleader>p :setl paste!<cr>
nnoremap <silent> <localleader>c :setl cursorcolumn! cuc?<cr>
nnoremap <silent> <localleader>l :setl list! list?<cr>
nnoremap <silent> <localleader>w :setl wrap! wrap?<cr>
nnoremap <silent> <localleader>s :setl spell! spelllang=en_us<cr>
nnoremap <silent> <localleader>f :setl foldenable! nofen?<cr>
nnoremap <silent> <localleader>b :let &bg=(&bg=='dark'?'light':'dark')<cr>

" Buffer switching
nnoremap <silent> [b    :bprevious<cr>
nnoremap <silent> ]b    :bnext<cr>
nnoremap <silent> [B    :bfirst<cr>
nnoremap <silent> ]B    :blast<cr>
nnoremap <silent> <c-q> :bdelete<cr>

" Tab switching
nnoremap <silent> [t    :tabprevious<cr>
nnoremap <silent> ]t    :tabnext<cr>
nnoremap <silent> [T    :tabfirst<cr>
nnoremap <silent> ]T    :tablast<cr>
nnoremap <silent> <c-t> :tabnew<cr>
inoremap <silent> <c-t> <esc>:tabnew<cr>
nnoremap <silent> tt    <c-w>T

" Quickfox switching
nnoremap <silent> [q :cprevious<cr>
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [Q :cfirst<cr>
nnoremap <silent> ]Q :clast<cr>

" LocationList switching
nnoremap <silent> [l :lprevious<cr>
nnoremap <silent> ]l :lnext<cr>
nnoremap <silent> [L :lfirst<cr>
nnoremap <silent> ]L :llast<cr>

" Preview window switching
nnoremap <silent> [<c-t> :ptprevious<cr>
nnoremap <silent> ]<c-t> :ptnext<cr>

" Window switching in normal mode
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Move lines left or right
vnoremap <silent> <s-tab> <gv
vnoremap <silent> <tab> >gv

" Move lines up or down
vnoremap <silent> <up>   :m '<-2<cr>gv=gv
vnoremap <silent> <down> :m '>+1<cr>gv=gv

" Search in selected visual block
vnoremap / :<c-u>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<cr>

" Fast save
noremap  <silent> <c-s> :update<cr>
inoremap <silent> <c-s> <esc>:update<cr>

" Replace a word
noremap <silent> <space>y yiw
noremap <silent> <space>p viw"0p

" Do not yank when x
noremap <silent> x  "_x

" Move vertically by visual line
nnoremap <silent> <expr> j v:count ? 'j' : 'gj'
nnoremap <silent> <expr> k v:count ? 'k' : 'gk'
vnoremap <silent> <expr> j v:count ? 'j' : 'gj'
vnoremap <silent> <expr> k v:count ? 'k' : 'gk'

" Switch to working directory of the open file
nnoremap <leader>cd :<c-u>lcd %:p:h<cr>:pwd<cr>

" Turn off search highlight
nnoremap <silent> <space>n :nohlsearch<cr>

" Open terminal on the right
nnoremap <silent> <space>t :terminal<cr>

" Hex read
nnoremap <silent> <space>hr :%!xxd<cr> :set filetype=xxd<cr>
" Hex write
nnoremap <silent> <space>hw :%!xxd -r<cr> :set binary<cr> :set filetype=<cr>

" Map w!! to write file with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Reselect the text that has just been pasted
nnoremap <silent> <space>s `[V`]

" Select all content
noremap <silent> <space>aa ggVG

" Resize window
noremap <silent> <space>- :resize -2<cr>
noremap <silent> <space>= :resize +2<cr>
noremap <silent> <space>[ :vertical resize -2<cr>
noremap <silent> <space>] :vertical resize +2<cr>
noremap <silent> <space>/ :wincmd =<cr>

" Correct vim exit command
cnoreabbrev Wq      wq
cnoreabbrev Wa      wa
cnoreabbrev wQ      wq
cnoreabbrev WQ      wq
cnoreabbrev W       w
cnoreabbrev Q       q
cnoreabbrev Qall    qall

" ============> Custom <============
" ----> Highlights
function! MyHighlights() abort
    highlight Normal        ctermbg=NONE guibg=NONE
    highlight NonText       ctermbg=NONE guibg=NONE
    highlight CursorLineNr  ctermbg=NONE guibg=NONE
    highlight LineNr        ctermbg=NONE guibg=NONE
    highlight CursorLine    ctermbg=NONE guibg=NONE
    highlight SpecialKey    ctermbg=NONE guibg=NONE
    highlight EndOfBuffer   ctermbg=NONE guibg=NONE
    highlight Folded        ctermbg=NONE guibg=NONE
    highlight FoldColumn    ctermbg=NONE guibg=NONE
    highlight DiffAdd       ctermbg=NONE guibg=NONE
    highlight DiffChange    ctermbg=NONE guibg=NONE
    highlight DiffDelete    ctermbg=NONE guibg=NONE
endfunction

augroup Highlights
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

" ----> Color
silent! colorscheme gruvbox8_hard

" ----> Filetype
augroup FileTypeCustom
    autocmd!
    autocmd FileType html,css,less,sass,scss      setl sw=2 ts=2 sts=2
    autocmd FileType json,jsonnet,markdown,yaml   setl sw=2 ts=2 sts=2
    autocmd FileType javascript,typescript,lua    setl sw=2 ts=2 sts=2

    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType yaml setl indentexpr=
    autocmd FileType make setl noexpandtab
    autocmd FileType gitcommit setl textwidth=72 colorcolumn=+1
augroup END

" ----> Tricks
augroup VimTricks
    autocmd!
    " trim trailing whitespace on write
    autocmd BufWritePre * if !&bin | exe 'normal mz' | exe ':keepp %s/\v\s+$//ge' | exe 'normal `z' | endif
    " remember cursor position
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &ft !~# 'commit\|xxd\|gitrebase\|tutor' && !&diff | exe "normal! g`\"" | endif
    " close the quickfix or locationlist window when exiting
    autocmd QuitPre     * if empty(&buftype) | cclose | lclose | endif
    " auto source $MYVIMRC
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    " automatically equalize windows when vim is resized
    autocmd VimResized * wincmd =
augroup END

" ----> Disable options for large files
function! DisableForLargeFiles() abort
    let l:threshold = 1024 * 1024 * 10  " 10M
    let l:size = getfsize(expand('<afile>'))
    if l:size < l:threshold | return | endif
    setl syntax=off
    setl eventignore+=FileType,BufEnter,BufLeave,BufWinEnter,BufWinLeave
    setl bufhidden=unload
    setl buftype=nowrite

    setl nocursorline nocursorcolumn
    setl nofoldenable foldmethod=manual
    setl nohlsearch noignorecase noincsearch
    setl nonumber norelativenumber
    setl signcolumn=no

    setl noswapfile noundofile nowritebackup
    setl nobackup
    setl noautoindent nosmartindent
    setl lazyredraw
endfunction

augroup LargeFile
    autocmd!
    autocmd BufReadPre * call DisableForLargeFiles()
augroup END

" ----> Open current buffer directory in finder or explorer
if has('mac')
    nnoremap <silent> <leader>e :silent execute '![ -f "%:p" ] && open -R "%:p" \|\| open "%:p:h"' \| redraw!<cr>
    nnoremap <silent> <leader>E :silent execute '!open .' \| redraw!<cr>
elseif has('linux')
    nnoremap <silent> <leader>e :silent execute '!xdg-open "%:p:h"' \| redraw!<cr>
    nnoremap <silent> <leader>E :silent execute '!xdg-open .' \| redraw!<cr>
endif
