" Tarrex's vimrc
"       ------ Enjoy vim, enjoy coding.

" ============> Prepare <============
let g:env       = {}
let g:env.mac   = has('mac') || has('macunix')
let g:env.linux = has('linux')

let g:dep       = {}
let g:dep.rg    = executable('rg')
let g:dep.curl  = executable('curl')
let g:dep.node  = executable('npm') || executable('yarn')

let g:feat      = {}
let g:feat.py3  = has('python3')

let g:nvim      = has('nvim')
let g:vimdir    = $HOME . '/.vim'

" ============> General <============
if &compatible
    set nocompatible                    " be iMproved, required
endif

syntax on                               " syntax highlighting
filetype indent plugin on               " filetype detection on

set number                              " print the line number in front of each line
set noruler                             " don't show the line and column number of the cursor position, separated by a comma
set nowrap                              " don't wrap lines longer than the width of the window
set modeline                            " allow setting options via buffer content
set showcmd                             " show (partial) command in the last line of the screen
set noshowmatch                         " don't briefly jump to the matching one when a bracket is inserted
set noshowmode                          " don't display Insert, Replace or Visual mode message on the last line
set laststatus=2                        " show status line
set display=lastline                    " as much as possible of the last line in a window will be displayed
if getfsize(@%) < 10 * 1024 * 1024      " if file size more than 10MB, don't show cursorline and cursorcolumn
    set cursorline                      " show underline for the cursor's line
    if has('patch-8.1.2019')
        set cursorlineopt=number        " highlight the line number of the cursor if could
    endif
endif
if has('patch-8.1.1564')
    set signcolumn=number               " display signs in the 'number' column if could else 'auto'
endif
set background=dark                     " try to use colors that look good on a dark background
if $TERM_PROGRAM !=# 'Apple_Terminal'
    set termguicolors                       " enable GUI colors for the terminal to get truecolor
endif
set visualbell t_vb=                    " no beep or flash is wanted

set expandtab                           " covert tabs to spaces, insert real tab by ctrl-v<tab> if you want
set shiftround                          " round indent to multiple of 'shiftwidth'
set shiftwidth=4                        " number of spaces to use for each step of (auto)indent
set tabstop=4                           " number of spaces that a <tab> in the file counts for
set softtabstop=4                       " number of spaces that a <tab> counts for while performing editing operations
set smarttab                            " be smart when use tabs
set autoindent                          " copy indent from current line when starting a new line

set linebreak                           " break lines at word boundaries
set breakindent                         " every wrapped line will continue visually indented
set showbreak=↪\                        " string to put at the start of lines that have been wrapped

set hlsearch                            " highlight all search pattern results
set ignorecase                          " ignore case in search patterns.
set incsearch                           " real time show the search case
set smartcase                           " override the 'ignorecase' option if the search pattern contains upper case characters
if g:dep.rg
    set grepprg=rg\ --vimgrep           " rg as the program to call when using the Ex commands: `:[l]grep[add]`
    set grepformat=%f:%l:%c:%m,%f:%l:%m " how the output of rg must be parsed
endif

set encoding=utf-8                      " the character encoding used inside vim
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,latin1 " list of character encodings considered when starting to edit an existing file
set fileformats=unix,dos,mac            " gives the <eol> formats of editing a new buffer or reading a file
set termencoding=utf-8                  " encoding used for the terminal

set autoread                            " auto load the file when changed outside vim
set autowrite                           " auto write file when building or switching
set backspace=indent,eol,start          " the working of <bs>, <del>, ctrl-w and ctrl-u in insert mode
set nostartofline                       " cursor is kept in the same column (if possible)
set nojoinspaces                        " don't insert two spaces after a '.', '?' and '!' with a join command
set hidden                              " allow buffers to have changes without being displayed
set lazyredraw                          " don't redraw while executing macros, registers and other commands that have not been typed
set splitbelow                          " horizontally split below
set splitright                          " vertically split to the right
set ttyfast                             " indicates a fast terminal connection
set mouse=a                             " enable the mouse in all five modes
if !g:nvim
    set ttymouse=sgr                    " name of the terminal type for which mouse codes are to be recognized, necessary when running vim in tmux
    " set clipboard=autoselect,exclude:.* " enable clipboard with system
    set termwinkey=<c-_>                " the key that starts a CTRL-_ command in a terminal window
    set t_ut=                           " clearing uses the current background color
    set ttyscroll=3                     " maximum number of lines to scroll the screen
endif
set scrolloff=1                         " minimal number of screen lines to keep above and below the cursor
set sidescroll=5                        " minimal number of columns to scroll horizontally
set sidescrolloff=1                     " minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.

set history=1000                        " set how many lines of command history vim has to remember
set timeout                             " timeout for mappings
set timeoutlen=3000                     " set the timeout for mappings to 3s
set ttimeout                            " timeout for key codes
set ttimeoutlen=6                       " set the timeout for mappings to 6ms
set updatetime=2000                     " time delay for swap and cursor hold

set comments=                           " clear default comments value, let the filetype handle it
set commentstring=                      " clear default comment template
set include=                            " don't assume I'm editing C; let the filetype set this
set complete+=k                         " scan the files given with the 'dictionary' option
set completeopt=menu,menuone,noinsert   " use a popup menu to show the possible completions even if there is only one match
set completeopt+=noselect               " only insert the longest common text of the matches
if has('patch-8.1.1882')
    set completeopt+=popup              " add popup option for insert mode completion if could
    set completepopup=border:off        " used for the properties of the info popup when it is created
endif
set diffopt+=context:3                  " only 3 lines of context above/below a changed line (instead of 6)
set diffopt+=vertical                   " start diff mode with vertical splits (unless explicitly specified otherwise)
set diffopt+=foldcolumn:1               " use only 1 column for the foldcolumn, instead of 2 (vertical space is precious)
set diffopt+=hiddenoff                  " turn off diff mode automatically for a buffer which becomes hidden
set diffopt+=indent-heuristic           " use the indent heuristic for the internal diff library
set diffopt+=algorithm:patience         " use the `patience` diff algorithm
set formatoptions+=m                    " also break at a multibyte character above 255, useful for asian text where every character is a word on its own
set formatoptions+=B                    " when joining lines, don't insert a space between two multibyte characters
set formatoptions+=j                    " remove a comment leader when joining lines
set nrformats-=octal                    " treat numbers with a leading zero as decimal, not octal
set shortmess+=a                        " enable all sort of abbreviations
set shortmess+=c                        " don't give ins-completion-menu messages
set shortmess-=S                        " helps to avoid all the hit-enter prompts caused by file messages
if has('patch-8.2.0953')
    set spelloptions=camel              " when a word is CamelCased, assume "Cased" is a separate word
endif
set fillchars=vert:┃                    " vertical separators
set listchars=eol:¬                     " end of line
set listchars+=extends:»                " unwrapped text to screen right
set listchars+=precedes:«               " unwrapped text to screen left
set listchars+=tab:<->                  " tab characters, preserve width
set listchars+=nbsp:∅                   " non-breaking spaces
set breakat+=)]}                        " line break characters, default are ' ^I!@*-+;:,./?'
set virtualedit=block                   " allow virtual editing in Visual block mode
set whichwrap=b,s,h,l,<,>,[,]           " allow specified keys that move the cursor left/right to move to the previous/next line when the cursor is on the first/last character in the line
set matchpairs+=<:>,《:》,「:」,（:）,【:】     " pairs characters that the `%` command jumps from one to the other

set dictionary+=/usr/share/dict/words   " files that are used to lookup words for keyword completion commands
set path=.,**5                          " look in the directory of the current buffer non-recursively, and in the working directory recursively
set tags=./tags;                        " filenames for the tag command, file in the directory of the CURRENT FILE, then in its parent directory, then in the parent of the parent its parent directory, then in the parent of the parent
set noswapfile                          " don't create swapfile for the buffer
" let &directory = g:vimdir . '/tmp/swap'
" if !isdirectory(&directory)
"     silent call mkdir(&directory, 'p', 0700)
" endif
set backup                              " make a backup before overwriting a file
set backupext=.bak                      " string which is appended to a file name to make the name of the backup file
set backupskip+=/etc/cron.*/*           " list of file patterns that do not create backup file
let &backupdir = g:vimdir . '/tmp/backup'
if !isdirectory(&backupdir)
    silent call mkdir(&backupdir, 'p', 0700)
endif
set undofile                            " automatically saves undo history to an undo file
set undolevels=1000                     " maximum number of changes that can be undone
if g:nvim
    let &undodir = g:vimdir . '/tmp/nundo'
else
    let &undodir = g:vimdir . '/tmp/undo'
endif
if !isdirectory(&undodir)
    silent call mkdir(&undodir, 'p', 0700)
endif
set viminfo='100,:1000,<50,s10,h,!      " viminfo settings
if g:nvim
    let &viminfo.=',n' . g:vimdir . '/nviminfo'
else
    let &viminfo.=',n' . g:vimdir . '/viminfo'
endif

set wildmenu                            " show autocomplete for command menu
set wildmode=longest:full,full          " completion mode that is used for the character specified with 'wildchar'
set wildignorecase                      " ignore case when completing file names and directories
set wildignore=                         " completely ignoring files when expanding wildcards
set wildignore+=*.o,*.out,*.so,*.dll,*.egg,*.jar,*.class,*.py[cdow],*.obj,*~
set wildignore+=*.dex,*.a,*.pdb,*.lib,*.gem,*.test,*.swp,*.app
set wildignore+=*.log,*.sqlite*,*.min.js,*.min.css,*.map,*.tags,*.lock
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.tiff,*.webp,*.ico
set wildignore+=*[^0-9].gz,*.tgz,*.zip,*.gzip,*.[rt]ar,*.[7x]z,*.bz2,*.[di]mg,*.iso
set wildignore+=*.avi,*.mp[4v],*.m[4k]v,*.f[4l]v,*.rm,*.rmvb,*.wmv
set wildignore+=*.aac,*.ape,*.flac,*.mp3,*.ogg,*.wav,*.wma,*.webm
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf,*.azw*,*.xps
set wildignore+=*.ppt*,*.doc*,*.xls*,*.od[tspg],*.pages,*.numbers,*.key,*.wps
set wildignore+=*.msi,*.exe,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*
set wildignore+=*/dist/*,*/tmp/*,*/.Trash/*,*/.rbenv/*,*/__pycache__/*
set wildignore+=.git,*.git,.svn,.idea,.vscode,.vim
set wildignore+=*DS_Store,*Thumbs.db

" ============> Plugins <============
let s:vimplug = g:vimdir . '/autoload/plug.vim'
if empty(glob(s:vimplug))
    if !g:dep.curl
        echomsg 'You have to install curl or install vim-plug manually!'
        finish
    endif
    silent execute '!echo "Installing Vim-Plug..."'
    silent execute '!curl --compressed --create-dirs --progress-bar -fLo ' . s:vimplug .
                 \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let s:coc = g:vimdir . '/coc-settings.json'
if empty(glob(s:coc))
    if g:dep.node
        silent execute '!echo "Download coc-settings.json..."'
        silent execute '!curl --compressed --create-dirs --progress-bar -fLo ' . s:coc .
                     \ ' https://raw.githubusercontent.com/tarrex/dotfiles/master/coc-settings.json'
    endif
endif

let g:plug_url_format = 'git@github.com:%s.git'

call plug#begin(g:vimdir . '/plugged')

" Plug 'lifepillar/vim-gruvbox8'
Plug 'haishanh/night-owl.vim'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'tommcdo/vim-exchange'
Plug 'chrisbra/colorizer', { 'on': 'ColorToggle' }
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
if g:dep.node | Plug 'neoclide/coc.nvim' | else | Plug 'skywind3000/vim-auto-popmenu' | endif
if g:feat.py3 | Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets' | endif
Plug 'dense-analysis/ale'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'yianwillis/vimcdoc'
Plug '$VIMRUNTIME/pack/dist/opt/matchit'
Plug 'fatih/vim-go',               { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'rust-lang/rust.vim',         { 'for': 'rust' }
Plug 'kovisoft/paredit',           { 'for': 'scheme' }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown', 'on': 'TableModeToggle' }
Plug 'tarrex/nginx.vim',           { 'for': 'nginx' }
Plug 'mtdl9/vim-log-highlighting', { 'for': 'log' }
Plug 'cespare/vim-toml',           { 'for': 'toml' }
if g:nvim | Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} | endif

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
        \ 'colorscheme': 'solarized',
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
        \   'filename':     'LightlineFilename',
        \   'linter':       'LightlineLinter',
        \   'filesize':     'LightlineFileSize',
        \   'fileformat':   'LightLineFileFormat',
        \   'fileencoding': 'LightLineFileEncoding',
        \   'filetype':     'LightLineFileType'
        \ }
    \ }

    let s:specific_fts = ['qf', 'help', 'man', 'netrw', 'vista']

    function! LightLineMode() abort
        return (&ft ==? 'qf' && getwininfo(win_getid())[0].loclist) ? 'Location' :
            \ &ft ==? 'qf' ? 'QuickFix' :
            \ &ft ==? 'help' ? 'Help' :
            \ &ft ==? 'man' ? 'Man' :
            \ &ft ==? 'netrw' ? 'Netrw' :
            \ &ft ==? 'vista' ? 'Vista' :
            \ lightline#mode()
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
        return index(s:specific_fts, &ft) >= 0 ? '' :
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
                \ '%dW %dE',
                \ all_non_errors,
                \ all_errors
            \ )
        else
            return ''
        endif
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
        return index(s:specific_fts, &ft) >= 0 ? ''
            \ : printf('%.1f%s', l:bytes, l:units[l:idx])
    endfunction

    function! LightLineFileFormat() abort
        if (winwidth(0) < 60 || mode() == 't') | return '' | endif
        return index(s:specific_fts, &ft) >= 0 ? ''
            \ : &fileformat
    endfunction

    function! LightLineFileEncoding() abort
        if (winwidth(0) < 50 || mode() == 't') | return '' | endif
        return index(s:specific_fts, &ft) >= 0 ? '' :
            \ &fenc !=# '' ? &fenc : &enc
    endfunction

    function! LightLineFileType() abort
        if (winwidth(0) < 40 || mode() == 't') | return '' | endif
        return index(s:specific_fts, &ft) >= 0 ? '' :
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
    nmap     S    <em>

    nmap <em>j <Plug>(easymotion-s2)
    xmap <em>j <Plug>(easymotion-s2)
    nmap <em>/ <Plug>(easymotion-sn)
    xmap <em>/ <Plug>(easymotion-sn)
    map  <em>k <Plug>(easymotion-bd-jk)
    nmap <em>k <Plug>(easymotion-overwin-line)
    map  <em>S <Plug>(easymotion-bd-w)
    nmap <em>S <Plug>(easymotion-overwin-w)
    map  <em>w <Plug>(easymotion-bd-w)
    nmap <em>w <Plug>(easymotion-overwin-w)
endif

" ----> terryma/vim-multiple-cursors
if HasPlug('vim-multiple-cursors')
    let g:multi_cursor_use_default_mapping = 0

    nnoremap <mc> <nop>
    nmap     C    <mc>

    let g:multi_cursor_start_word_key      = '<mc>'
    let g:multi_cursor_select_all_word_key = '<leader><mc>'
    let g:multi_cursor_start_key           = 'g<mc>'
    let g:multi_cursor_select_all_key      = 'g<leader><mc>'
    let g:multi_cursor_next_key            = '<c-n>'
    let g:multi_cursor_prev_key            = '<c-p>'
    let g:multi_cursor_skip_key            = '<c-x>'
    let g:multi_cursor_quit_key            = '<esc>'
endif

" ----> dhruvasagar/vim-table-mode
if HasPlug('vim-table-mode')
    let g:table_mode_corner = '|'
endif

" ----> liuchengxu/vista.vim
if HasPlug('vista.vim')
    let g:vista_sidebar_position         = 'vertical botright'
    let g:vista_sidebar_width            = 30
    let g:vista_echo_cursor              = 1
    let g:vista_cursor_delay             = 400
    if has('patch-8.2.0750') || g:nvim
        let g:vista_echo_cursor_strategy = 'floating_win'
    else
        let g:vista_echo_cursor_strategy = 'echo'
    endif
    let g:vista_close_on_jump            = 0
    let g:vista_stay_on_open             = 1
    let g:vista_blink                    = [2, 100]
    let g:vista_default_executive        = 'ctags'
    let g:vista_fzf_preview              = ['right:50%']
    let g:vista_disable_statusline       = 1
    let g:vista#renderer#enable_icon     = 0

    if HasPlug('coc.nvim')
        nnoremap <localleader>t :Vista coc<cr>
    else
        nnoremap <localleader>t :Vista<cr>
    end
endif

" ----> junegunn/fzf.vim
if HasPlug('fzf.vim')
    let g:fzf_command_prefix = 'FZF'
    let g:fzf_layout         = { 'down': '40%' }
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
    if g:dep.rg
        let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!{'.shellescape(&wildignore).'}"'
    endif
    command! -bang -nargs=* FZFRg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --smart-case ' .
        \      '--hidden --glob "!{'.shellescape(&wildignore).'}" -- '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(), <bang>0)

    nnoremap <silent> <space>fb  :FZFBuffers<cr>
    nnoremap <silent> <space>fc  :FZFBCommits<cr>
    nnoremap <silent> <space>ff  :FZFFiles<cr>
    nnoremap <silent> <space>fg  :FZFGFiles?<cr>
    nnoremap <silent> <space>fh  :FZFHistory<cr>
    nnoremap <silent> <space>fhc :FZFHistory:<cr>
    nnoremap <silent> <space>fhs :FZFHistory/<cr>
    nnoremap <silent> <space>fr  :FZFRg<cr>
    nnoremap <silent> <space>fs  :FZFSnippets<cr>
    nnoremap <silent> <space>ft  :FZFBTags<cr>

    command! -bar -bang FZFMapsI call fzf#vim#maps("i", <bang>0)
    command! -bar -bang FZFMapsN call fzf#vim#maps("n", <bang>0)
    command! -bar -bang FZFMapsO call fzf#vim#maps("o", <bang>0)
    command! -bar -bang FZFMapsV call fzf#vim#maps("v", <bang>0)
    command! -bar -bang FZFMapsX call fzf#vim#maps("x", <bang>0)
endif

" ----> tmsvg/pear-tree
if HasPlug('pear-tree')
    let g:pear_tree_pairs = {
        \ '(': {'closer': ')'},
        \ '[': {'closer': ']'},
        \ '{': {'closer': '}'},
        \ "'": {'closer': "'"},
        \ '"': {'closer': '"'}
    \ }
    let g:pear_tree_repeatable_expand = 0
    augroup PearTree
        autocmd!
        autocmd FileType markdown let b:pear_tree_pairs = {
                                      \ '$': {'closer': '$'},
                                      \ '$$': {'closer': '$$'}
                                  \ }
    augroup END
endif

" ----> mbbill/undotree
if HasPlug('undotree')
    nnoremap <silent> <localleader>u :UndotreeToggle<cr>
endif

" ----> neoclide/coc.nvim
if HasPlug('coc.nvim')
    if &backup | set nobackup | endif
    if &writebackup | set nowritebackup | endif
    let g:coc_disable_startup_warning = 1
    let g:coc_global_extensions       = [
        \ 'coc-word',
        \ 'coc-emoji',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-json',
        \ 'coc-yaml',
        \ 'coc-tsserver',
        \ 'coc-pyright',
        \ 'coc-vimlsp',
        \ 'coc-translator'
    \]

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
    if g:nvim
        inoremap <silent><expr> <c-space> coc#refresh()
    else
        inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <cr> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
        elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
        else
            execute '!' . &keywordprg . " " . expand('<cword>')
        endif
    endfunction

    augroup Coc
        autocmd!
        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        " Options for coc-css
        autocmd FileType scss setl iskeyword+=@-@
    augroup END

    nnoremap <coc> <Nop>
    nmap     ;     <coc>

    " Symbol renaming.
    nmap <coc>r <Plug>(coc-rename)

    " Formatting selected code.
    xmap <coc>f <Plug>(coc-format-selected)
    nmap <coc>f <Plug>(coc-format-selected)

    " Applying codeAction to the selected region.
    xmap <coc>as <Plug>(coc-codeaction-selected)
    nmap <coc>as <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <coc>ac <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <coc>qf <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap <coc>if <Plug>(coc-funcobj-i)
    omap <coc>if <Plug>(coc-funcobj-i)
    xmap <coc>af <Plug>(coc-funcobj-a)
    omap <coc>af <Plug>(coc-funcobj-a)
    xmap <coc>ic <Plug>(coc-classobj-i)
    omap <coc>ic <Plug>(coc-classobj-i)
    xmap <coc>ac <Plug>(coc-classobj-a)
    omap <coc>ac <Plug>(coc-classobj-a)

    " Remap <c-f> and <c-b> for scroll float windows/popups.
    if has('patch-8.2.0750') || g:nvim
        nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
        nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
        inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
        vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
    endif

    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <coc>v <Plug>(coc-range-select)
    xmap <silent> <coc>v <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold   :call CocAction('fold', <f-args>)
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <coc>d :<c-u>CocDiagnostics<cr>
    nnoremap <silent><nowait> <coc>D :<c-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <coc>e :<c-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <coc>c :<c-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <coc>o :<c-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <coc>s :<c-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <coc>j :<c-u>CocNext<cr>
    " Do default action for previous item.
    nnoremap <silent><nowait> <coc>k :<c-u>CocPrev<cr>
    " Resume latest coc list.
    nnoremap <silent><nowait> <coc>p :<c-u>CocListResume<cr>

    function! s:coc_uninstall_all() abort
        for e in g:coc_global_extensions
            execute 'CocUninstall ' . e
        endfor
    endfunction

    command! CocInstallAll   CocInstall -sync
    command! CocUninstallAll call s:coc_uninstall_all()

    function! s:coc_extension_exist(name) abort
        let l:extension = get(g:, 'coc_global_extensions', {})
        return (count(l:extension, a:name) != 0)
    endfunction

    " coc-translator
    if s:coc_extension_exist('coc-translator')
        nmap <coc>t <Plug>(coc-translator-p)
        vmap <coc>t <Plug>(coc-translator-pv)
    endif
endif

" ----> sirver/ultisnips
if HasPlug('ultisnips')
    let g:UltiSnipsEnableSnipMate     = 0
    let g:UltiSnipsExpandTrigger      = '<nop>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
endif

" ----> skywind3000/vim-auto-popmenu
if HasPlug('vim-auto-popmenu')
    let g:apc_enable_ft = { '*': 1 }
endif

" ----> dense-analysis/ale
if HasPlug('ale')
    let g:ale_command_wrapper             = 'nice -n5'
    let g:ale_maximum_file_size           = 10 * 1024 * 1024
    let g:ale_echo_msg_error_str          = 'E'
    let g:ale_echo_msg_info_str           = 'I'
    let g:ale_echo_msg_warning_str        = 'W'
    let g:ale_echo_msg_log_str            = 'L'
    let g:ale_echo_msg_format             = '%severity%: [%linter%] %s'
    let g:ale_loclist_msg_format          = '[%linter%] %code: %%s'
    let g:ale_sign_error                  = '>>'
    let g:ale_sign_warning                = '--'
    let g:ale_sign_info                   = '~~'
    let g:ale_set_highlights              = 0
    let g:ale_set_quickfix                = 1
    let g:ale_list_window_size            = 6
    let g:ale_open_list                   = 'on_save'
    let g:ale_fix_on_save                 = 1
    let g:ale_fixers                      = {
        \ 'go':         ['goimports'],
        \ 'python':     ['black'],
        \ 'rust':       ['rustfmt'],
        \ 'c':          ['clang-format'],
        \ 'cpp':        ['clang-format'],
        \ 'javascript': ['eslint'],
        \ 'typescript': ['tslint'],
        \ 'vue':        ['prettier'],
        \ 'html':       ['prettier'],
        \ 'css':        ['prettier'],
        \ 'less':       ['prettier'],
        \ 'sass':       ['prettier'],
        \ 'scss':       ['prettier'],
        \ 'json':       ['prettier'],
        \ 'yaml':       ['prettier'],
        \ 'graphql':    ['prettier'],
        \ 'sh':         ['shfmt'],
        \ 'markdown':   ['prettier']
    \}
    let g:ale_c_clangformat_style_option  = '{BasedOnStyle: LLVM, IndentWidth: 4}'
    let s:ale_prettier_common_options     = '--print-width 120 --single-quote true --trailing-comma all --bracket-same-line'
    let g:ale_javascript_prettier_options = '--tab-width 4 '.s:ale_prettier_common_options
    augroup PrettierForFileTypes
        autocmd!
        autocmd FileType html,css,scss,sass,yaml,markdown let b:ale_javascript_prettier_options = '--tab-width 2 '.s:ale_prettier_common_options
    augroup END
    let g:ale_lint_on_enter               = 0
    let g:ale_lint_on_save                = 1
    let g:ale_lint_on_text_changed        = 0
    let g:ale_linters_explicit            = 1
    let g:ale_linters                     = {
        \ 'go':         ['golangci-lint', 'gopls'],
        \ 'python':     ['pyflakes'],
        \ 'rust':       ['analyzer', 'rls'],
        \ 'java':       ['javac'],
        \ 'c':          ['cc', 'clangd'],
        \ 'cpp':        ['cc', 'clangd'],
        \ 'javascript': ['eslint'],
        \ 'typescript': ['tslint'],
        \ 'vue':        ['eslint'],
        \ 'html':       ['stylelint'],
        \ 'css':        ['stylelint'],
        \ 'less':       ['stylelint'],
        \ 'sass':       ['stylelint'],
        \ 'scss':       ['stylelint'],
        \ 'json':       ['prettier'],
        \ 'yaml':       ['yamllint'],
        \ 'graphql':    ['eslint'],
        \ 'sh':         ['shell'],
        \ 'markdown':   ['languagetool'],
        \ 'text':       ['languagetool']
    \ }
    let g:ale_go_golangci_lint_options    = ''

    nmap <silent> [a <Plug>(ale_previous)
    nmap <silent> ]a <Plug>(ale_next)
    nmap <silent> [A <Plug>(ale_first)
    nmap <silent> ]A <Plug>(ale_last)

    highlight link ALEErrorSign CursorLineNr
    highlight link ALEWarningSign CursorLineNr
endif

" ----> fatih/vim-go
if HasPlug('vim-go')
    let g:go_version_warning               = 0
    let g:go_code_completion_enabled       = 0
    let g:go_updatetime                    = 0
    let g:go_jump_to_error                 = 0
    let g:go_fmt_autosave                  = 0
    let g:go_imports_autosave              = 0
    let g:go_mod_fmt_autosave              = 0
    let g:go_doc_keywordprg_enabled        = 0
    if has('patch-8.2.0012') || g:nvim
        let g:go_doc_popup_window          = 1
    endif
    let g:go_def_mapping_enabled           = 0
    let g:go_textobj_enabled               = 0
    let g:go_list_height                   = 6
    let g:go_list_type                     = 'quickfix'
    let g:go_alternate_mode                = 'vsplit'
    let g:go_echo_command_info             = 0
    let g:go_echo_go_info                  = 0
    let g:go_addtags_transform             = 'camelcase'
    let g:go_highlight_extra_types         = 1
    let g:go_highlight_functions           = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_function_calls      = 1
    let g:go_highlight_types               = 1
    let g:go_highlight_fields              = 1
    let g:go_highlight_build_constraints   = 1
    let g:go_highlight_generate_tags       = 1
    let g:go_highlight_string_spellcheck   = 0
    let g:go_highlight_diagnostic_errors   = 0
    let g:go_highlight_diagnostic_warnings = 0
    let g:go_debug_address                 = '127.0.0.1:8181'
    let g:go_debug_log_output              = 'debugger'

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
        autocmd FileType go nmap <space>gq :GoDebugStop<cr>
    augroup END
endif

" ----> rust-lang/rust.vim
if HasPlug('rust.vim')
    augroup Rust
        autocmd!
        autocmd FileType rust nmap <space>rb :Cbuild<cr>
        autocmd FileType rust nmap <space>rr :Crun<cr>
    augroup END
endif

" ============> Custom <============
" ----> Highlights
" Some custom highlights
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
silent! colorscheme night-owl

" ----> Key maps
let g:mapleader      = ','              " set vim map leader, <leader>
let g:maplocalleader = '\'              " set vim local map leader, <localleader>

" Clipboard
if g:env.mac
    set clipboard=unnamed
    noremap <leader>y "*y
    noremap <leader>p "*p
elseif g:env.linux
    set clipboard=unnamedplus
    noremap <leader>y "+y
    noremap <leader>p "+p
endif

" Toggle number,paste,cuc,list,wrap,spell and so on.
nnoremap <silent> <localleader>n :setl number! nu?<cr>
nnoremap <silent> <localleader>r :setl relativenumber! rnu?<cr>
nnoremap <silent> <localleader>p :setl paste!<cr>
nnoremap <silent> <localleader>c :setl cursorcolumn! cuc?<cr>
nnoremap <silent> <localleader>l :setl list! list?<cr>
nnoremap <silent> <localleader>w :setl wrap! wrap?<cr>
nnoremap <silent> <localleader>s :setl spell! spelllang=en_us<cr>
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
nnoremap <silent> tt    :<c-u>call MoveToTab()<cr>
function! MoveToTab() abort
    tab split | tabprevious
    if winnr('$') > 1 | close | elseif bufnr('$') > 1 | buffer # | endif
    tabnext
endfunction

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

" Window switching in terminal mode
if has('terminal')
    tnoremap <c-h> <c-_>h
    tnoremap <c-j> <c-_>j
    tnoremap <c-k> <c-_>k
    tnoremap <c-l> <c-_>l
    tnoremap <silent> <c-q> <c-_>:q!<cr>
endif

" Search will center on the line it's found in, conflict with shortmess-=S option
" nnoremap n nzzzv
" nnoremap N Nzzzv

" Move lines left or right
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" Move lines up or down
" nnoremap <silent> <up>   :m-2<cr>==
" nnoremap <silent> <down> :m+1<cr>==
vnoremap <silent> <up>   :m '<-2<cr>gv=gv
vnoremap <silent> <down> :m '>+1<cr>gv=gv

" Search in selected visual block
vnoremap / :<c-u>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<cr>

" Fast save
noremap  <silent> <c-s> :update<cr>
inoremap <silent> <c-s> <esc>:update<cr>

" Move vertically by visual line
noremap  <silent> <expr> j v:count ? 'j' : 'gj'
noremap  <silent> <expr> k v:count ? 'k' : 'gk'
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

" Rotate tab size
nnoremap <silent> <space>v :let &ts=(&ts*2 > 16 ? 2 : &ts*2)<cr>:echo "tabstop:" . &ts<cr>

" Toggle current cursor position to top / center / bottom
noremap <expr> zz (winline() == (winheight(0) + 1) / 2) ?  'zt' : (winline() <= 2)? 'zb' : 'zz'

" Reselect the text that has just been pasted
nnoremap <silent> <space>p `[V`]

" Send output of previous global command to a new window
nnoremap <silent> <space>s :redir @a<cr>:g//<cr>:redir END<cr>:new<cr>:put! a<cr><cr>

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

" ----> Vim build
nnoremap <buffer> <space>m :w!<cr>:make<cr>
augroup VimBuild
    autocmd!
    autocmd FileType go      setl makeprg=go\ run\ %
    autocmd FileType python  setl makeprg=python3\ %
    autocmd FileType scheme  setl makeprg=chez\ --script\ %
augroup END

" ----> Filetype
augroup CustomByFileType
    autocmd!
    autocmd FileType qf setl nonu nornu
    autocmd FileType gitcommit setl spell
augroup END

" ----> Tricks
augroup VimTricks
    autocmd!
    " trim trailing whitespace on write
    autocmd BufWritePre * if !&bin | sil exe 'normal mz' | %s/\v\s+$//ge | sil exe 'normal `z' | endif
    " remember cursor position
    autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | sil exe "normal! g`\"" | endif
    " close the quickfix or locationlist window when exiting
    autocmd QuitPre     * if empty(&buftype) | cclose | lclose | endif
    " auto source $MYVIMRC
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    " don't list terminal buffer at buffer list
    if !g:nvim
        autocmd TerminalOpen * if &bt == 'terminal' | sil set nobl | endif
    endif
augroup END

" ----> Commands
command! -nargs=* -complete=mapping AllMaps map <args> | map! <args> | lmap <args>
command! RemoveBlankLine sil g/^$/d | noh | normal! ``
command! RTP echo substitute(&runtimepath, ',', "\n", 'g')
command! SaveAsUTF8 setl fenc=utf-8 | w
command! Tab2Space sil %s/\t/    /g | noh | normal! ``

" ----> Disable some vim built-in plugins
let g:loaded_2html_plugin    = 1        " tohtml
let g:loaded_getscript       = 1        " getscript
let g:loaded_getscriptPlugin = 1
let g:loaded_logiPat         = 1        " logipat
let g:loaded_vimball         = 1        " vimball
let g:loaded_vimballPlugin   = 1

" ----> Netrw
let g:netrw_altfile      = 1
let g:netrw_banner       = 1
let g:netrw_liststyle    = 1
let g:netrw_list_hide    = &wildignore
let g:netrw_preview      = 0
let g:netrw_sort_options = 'i'
let g:netrw_winsize      = 25

function! NetrwToggle() abort
    if exists("g:netrw_buffer") && bufexists(g:netrw_buffer)
        silent! execute "bd" . g:netrw_buffer | unlet g:netrw_buffer
    else
        silent! Lexplore | let g:netrw_buffer=bufnr("%")
    endif
endfunction
noremap <silent> <localleader>f :call NetrwToggle()<cr>

" ----> Zen mode
function! ZenModeToggle() abort
    if exists('s:zen_mode')
        set smd ru sc nu rnu ls=2
        highlight clear Normal
        syntax on
        unlet s:zen_mode
    else
        set nosmd noru nosc nonu nornu ls=0
        syntax off
        highlight Normal guifg=LightGrey ctermfg=LightGrey guibg=black ctermbg=black
        let s:zen_mode = 1
    endif
endfunction
nnoremap <silent> <space>z :call ZenModeToggle()<cr>

" ----> View changes after the last save
function! DiffWithSaved() abort
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    execute 'setlocal bt=nofile bh=wipe nobl noswf ro ft=' . filetype
    execute 'normal! ]c'
endfunction
nnoremap <silent> <space>d :call DiffWithSaved()<cr>

" ----> Toggle Quickfix / LocationList window
function! QuickfixToggle() abort
    if len(filter(getwininfo(), 'v:val.quickfix'))
        silent! cclose
    else
        silent! copen 6
    endif
endfunction
nnoremap <silent> <space>, :call QuickfixToggle()<cr>

function! LocationToggle() abort
    if len(filter(getwininfo(), 'v:val.loclist'))
        silent! lclose
    else
        silent! lopen 6
    endif
endfunction
nnoremap <silent> <space>. :call LocationToggle()<cr>

" ----> Open current buffer directory in finder or explorer
if g:env.mac
    nnoremap <leader>e :silent execute '![ -f "%:p" ] && open -R "%:p" \|\| open "%:p:h"' \| redraw!<cr>
    nnoremap <leader>E :silent execute '!open .' \| redraw!<cr>
elseif g:env.linux
    nnoremap <leader>e :silent execute '!xdg-open "%:p:h"' \| redraw!<cr>
    nnoremap <leader>E :silent execute '!xdg-open .' \| redraw!<cr>
endif

" ----> Echo start time when starting
if has('reltime')
    let s:startuptime = reltime()
    augroup StartupTime
        autocmd!
        autocmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
                            \ | echomsg 'StartupTime:' . reltimestr(s:startuptime) . 's'
    augroup END
endif

" ---> Generate security strings
function! GenUUID() abort
python3 << EOF
import uuid
vim.command('let uuid = \'%s\'' % str(uuid.uuid4()))
EOF
    execute 'normal i' . uuid . ''
endfunction
command! -nargs=* -range=% GenUUID call GenUUID()
noremap <silent> <localleader>gu :call GenUUID()<cr>

function! GenToken() abort
python3 << EOF
import secrets
vim.command('let token = \'%s\'' % str(secrets.token_hex(16)))
EOF
    execute 'normal i' . token . ''
endfunction
command! -nargs=* -range=% GenToken call GenToken()
noremap <silent> <localleader>gt :call GenToken()<cr>

set secure                              " ':autocmd', shell and write commands are not allowed in '.vimrc' and '.exrc' in the current directory and map commands are displayed
