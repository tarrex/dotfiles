" Tarrex's vimrc
"       ------ Enjoy vim, enjoy coding.

" ============> General <============
let s:vimdir = $HOME . '/.vim'  " vim config directory

if &compatible
    set nocompatible            " be iMproved, required
endif

syntax on                       " syntax highlighting
filetype indent plugin on       " filetype detection on

set number                      " print the line number in front of each line
set relativenumber              " show the line number relative to the line with the cursor in front of each line
set ruler                       " show the line and column number of the cursor position, separated by a comma
set nowrap                      " don't wrap lines longer than the width of the window

let s:bytes = getfsize(@%)
if s:bytes < 10 * 1024 * 1024   " 10MB
    set cursorline              " show underline for the cursor's line
    " set cursorcolumn            " show column line for the cursor's column
endif
silent! set cursorlineopt=number

set expandtab                   " covert tabs to spaces, insert real tab by ctrl-v<tab> if you want
set shiftround                  " round indent to multiple of 'shiftwidth'
set shiftwidth=4                " number of spaces to use for each step of (auto)indent
set tabstop=4                   " number of spaces that a <tab> in the file counts for
set softtabstop=4               " number of spaces that a <tab> counts for while performing editing operations
set smarttab                    " be smart when use tabs

set autoindent                  " copy indent from current line when starting a new line
set breakindent                 " every wrapped line will continue visually indented

set encoding=utf-8              " the character encoding used inside vim
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1 " list of character encodings considered when starting to edit an existing file
set fileformats=unix,dos,mac    " gives the <eol> formats of editing a new buffer or reading a file
" if &modifiable
"     set fileencoding=utf-8      " the character encoding for the file of this buffer
"     set fileformat=unix         " gives the <eol> of the current buffer
" endif

set ambiwidth=double            " use twice the width of ASCII characters for East Asian Width Class Ambiguous
set delcombine                  " delete each combining character on its own
set backspace=indent,eol,start  " the working of <bs>, <del>, ctrl-w and ctrl-u in insert mode

set hidden                      " allow buffers to have changes without being displayed
set autoread                    " auto load the file when changed outside vim
set autowrite                   " auto write file when building or switching
set lazyredraw                  " don't redraw while executing macros, registers and other commands that have not been typed
set report=0                    " always reporting number of lines changed
set ttyfast                     " indicates a fast terminal connection
set ttimeout                    " timeout for key codes
set ttimeoutlen=100             " wait up to 100ms for key codes

set ignorecase                  " ignore case in search patterns.
set smartcase                   " override the 'ignorecase' option if the search pattern contains upper case characters
set incsearch                   " real time show the search case
set hlsearch                    " highlight all search pattern results
if executable('rg')
    let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '') " Program to use for the :grep command
endif

set splitbelow                  " horizontally split below
set splitright                  " vertically split to the right
set noequalalways               " all the windows are automatically made the same size after splitting or closing a window

set pastetoggle=<F4>            " set paste toggle
silent! set termwinkey=<c-w>    " the key that starts a CTRL-W command in a terminal window

set background=dark             " try to use colors that look good on a dark background
silent! set termguicolors       " enable GUI colors for the terminal to get truecolor

set noswapfile                  " don't create swapfile for the buffer
let &backupdir = s:vimdir . '/tmp'
if !isdirectory(&backupdir)
    silent! call mkdir(&backupdir, 'p', 0755)
endif
set backup                                      " make a backup before overwriting a file
set backupext=.bak                              " string which is appended to a file name to make the name of the backup file
set backupskip+=/etc/cron.*/*                   " list of file patterns that do not create backup file

let &undodir = s:vimdir . '/undodir'            " list of directory names for undo files, separated with commas
if !isdirectory(&undodir)
    silent! call mkdir(&undodir, 'p', 0755)
endif
set undofile                                    " automatically saves undo history to an undo file
set undolevels=1000                             " maximum number of changes that can be undone

set viminfo='100,:10000,<50,s10,h,!             " viminfo settings
if has('nvim')
    let &viminfo.=',n' . s:vimdir . '/nviminfo' " viminfo file location
else
    let &viminfo.=',n' . s:vimdir . '/viminfo'  " viminfo file location
endif
set history=10000                               " set how many lines of command history vim has to remember

set dictionary+=/usr/share/dict/words           " files that are used to lookup words for keyword completion commands

silent! set signcolumn=number   " display signs in the 'number' column if could else 'auto'
set comments=                   " clear default comments value, let the filetype handle it
set include=                    " don't assume I'm editing C; let the filetype set this
set nrformats-=octal            " treat numbers with a leading zero as decimal, not octal
set formatoptions+=j            " delete comment leaders when joining lines, if supported
set shortmess-=S                " helps to avoid all the hit-enter prompts caused by file messages
set shortmess+=c                " don't give ins-completion-menu messages
set laststatus=2                " show status line
set display=lastline            " as much as possible of the last line in a window will be displayed
set scrolloff=1                 " minimal number of screen lines to keep above and below the cursor
set sidescrolloff=1             " minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
set nojoinspaces                " don't insert two spaces after a '.', '?' and '!' with a join command
set matchpairs=(:),{:},[:],《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:” " characters that form pair, % command jumps to the other
set showmatch                   " show the match pairs  can be seen on the screen
set nomodeline                  " don't allow setting options via buffer content
set breakat=                    " line break character ' ', default are ' ^I!@*-+;:,./?'
set linebreak                   " break lines at word boundaries
set updatetime=300              " time delay for swap and cursor hold
set visualbell t_vb=            " no beep or flash is wanted
set ttymouse=xterm2             " name of the terminal type for which mouse codes are to be recognized, necessary when running vim in tmux
set mouse=a                     " enable the mouse in all five modes
silent! set clipboard=unnamed   " enable clipboard with system

set listchars+=extends:>        " unwrapped text to screen right
set listchars+=precedes:<       " unwrapped text to screen left
set listchars+=tab:\|-          " tab characters, preserve width
set listchars+=trail:_          " trailing spaces
set listchars+=nbsp:+           " non-breaking spaces

set completeopt+=longest,menuone                " list of options for insert mode completion
silent! set completeopt+=popup                  " add popup option for insert mode completion if could
silent! set completepopup=border:off            " used for the properties of the info popup when it is created

set diffopt+=vertical,context:3,foldcolumn:0    " option settings for diff mode
if &diffopt =~ 'internal'
    set diffopt+=indent-heuristic,algorithm:patience
endif

set wildmenu                    " show autocomplete for command menu
set wildmode=longest:full,full  " completion mode that is used for the character specified with 'wildchar'

set suffixes=                   " get a lower priority when multiple files match a wildcard
set suffixes+=.bak,~,.o,.h,.info,.swp,.obj,.py[cdow],.egg-info,.class

set wildignorecase              " ignore case when completing file names and directories
set wildignore=                 " completely ignoring files when expanding wildcards
set wildignore+=*.o,*.out,*.so,*.dll,*.egg,*.jar,*.class,*.py[cdow],*.obj,*~
set wildignore+=*.dex,*.a,*.pdb,*.lib,*.gem,*.test,*.swp,*.app
set wildignore+=*.log,*.sqlite*,*.min.js,*.min.css,*.map,*.tags,*.lock
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.tiff,*.webp,*.ico
set wildignore+=*.zip,*.[rt]ar,*.[7gx]z,*.gzip,*.bz2,*.tgz,*.[di]mg,*.iso
set wildignore+=*.avi,*.mp[4v],*.m[4k]v,*.f[4l]v,*.rm,*.rmvb,*.wmv
set wildignore+=*.aac,*.ape,*.flac,*.mp3,*.ogg,*.wav,*.wma,*.webm
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf,*.azw*,*.xps
set wildignore+=*.ppt*,*.doc*,*.xls*,*.od[tspg],*.pages,*.numbers,*.key,*.wps
set wildignore+=*.msi,*.exe,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*/node_modules/**,*/nginx_runtime/**,*/build/**,*/logs/**
set wildignore+=*/dist/**,*/tmp/**,*/.Trash/**,*/.rbenv/**
set wildignore+=.git,*.git,.svn,.idea,.vscode,.vim
set wildignore+=*DS_Store,*Thumbs.db

" ============> Plugins <============
let s:vimplug = s:vimdir . '/autoload/plug.vim'
if empty(glob(s:vimplug))
    if executable('curl')
        silent execute '!echo "Installing Vim-Plug..."'
        silent execute '!curl --compressed --create-dirs --progress-bar -fLo ' . s:vimplug .
                     \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
    else
        echomsg 'You have to install curl or install vim-plug manually!'
        finish
    endif
endif

let s:coc = s:vimdir . '/coc-settings.json'
if empty(glob(s:coc))
    if executable('curl')
        silent execute '!echo "Download coc-settings.json..."'
        silent execute '!curl --compressed --create-dirs --progress-bar -fLo ' . s:coc .
                     \ ' https://raw.githubusercontent.com/tarrex/dotfiles/master/coc-settings.json'
    else
        echomsg 'You have to install curl or download coc-settings.json manually!'
    endif
    if !executable('yarn') && !executable('npm')
        echomsg 'You have to install yarn or npm for coc.nvim plugin later!'
    endif
endif

call plug#begin(s:vimdir . '/plugged')

Plug 'nlknguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown', 'on': 'TableModeToggle' }
Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle' }
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'kovisoft/paredit', { 'for': 'scheme' }
Plug 'tarrex/nginx.vim', { 'for': 'nginx' }
Plug 'mtdl9/vim-log-highlighting', { 'for': 'log' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug '$VIMRUNTIME/pack/dist/opt/matchit'

call plug#end()

let s:plugs = get(g:, 'plugs', '{}')
function! s:has_plug(name) abort
    return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction

" ----> itchyny/lightline.vim
if s:has_plug('lightline.vim')
    let g:lightline = {
        \ 'enable': {
        \   'statusline': 1,
        \   'tabline': 0
        \ },
        \ 'colorscheme': 'solarized',
        \ 'active': {
        \   'left': [[ 'mode', 'paste' ],
        \           [ 'bufnum' ],
        \           [ 'readonly', 'filename' ]],
        \   'right': [[ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'linter', 'filesize', 'fileformat', 'fileencoding', 'filetype' ],
        \            [ 'tag' ]]
        \ },
        \ 'inactive': {
        \   'left': [[ 'mode' ],
        \           [ 'filename' ]],
        \   'right': [[ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'filetype' ]]
        \ },
        \ 'component_function': {
        \   'mode': 'LightLineMode',
        \   'filename': 'LightlineFilename',
        \   'linter': 'LightlineLinter',
        \   'filesize': 'LightlineFileSize',
        \   'fileformat': 'LightLineFileFormat',
        \   'fileencoding': 'LightLineFileEncoding',
        \   'filetype': 'LightLineFileType'
        \ }
    \ }

    function! LightLineMode() abort
        let fname = expand('%:t')
        return fname ==? '__vista__' ? 'Vista' :
            \ (&ft ==? 'qf' && getwininfo(win_getid())[0].loclist) ? 'Location' :
            \ &ft ==? 'qf' ? 'QuickFix' :
            \ &ft ==? 'netrw' ? 'Netrw' :
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
        return fname ==? '__vista__' ? '' :
            \ &ft ==? 'netrw' ? '' :
            \ ('' !=? fname ? fname : '[No Name]') .
            \ (&modified ? ' +' : '')
    endfunction

    function! LightlineLinter() abort
        if (winwidth(0) < 80 || mode() == 't') | return '' | endif
        let l:counts = ale#statusline#Count(bufnr(''))
        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors
        return l:counts.total == 0 ? '' : printf(
            \ '%dW %dE',
            \ all_non_errors,
            \ all_errors
        \ )
    endfunction

    function! LightlineFileSize() abort
        if (winwidth(0) < 70 || mode() == 't') | return '' | endif
        let l:bytes = getfsize(@%)
        if l:bytes <= 0
            return '0B'
        endif
        let l:units = ['B', 'K', 'M', 'G']
        let l:idx = 0
        while l:bytes >= 1024
            let l:bytes = l:bytes / 1024.0
            let l:idx += 1
        endwhile
        return printf('%.1f%s', l:bytes, l:units[l:idx])
    endfunction

    function! LightLineFileFormat() abort
        if (winwidth(0) < 60 || mode() == 't') | return '' | endif
        return &fileformat
    endfunction

    function! LightLineFileEncoding() abort
        if (winwidth(0) < 50 || mode() == 't') | return '' | endif
        return &fenc !=# '' ? &fenc : &enc
    endfunction

    function! LightLineFileType() abort
        if (winwidth(0) < 40 || mode() == 't') | return '' | endif
        return &ft !=# '' ? &ft : 'no ft'
    endfunction
endif

" ----> easymotion/vim-easymotion
if s:has_plug('vim-easymotion')
    let g:EasyMotion_do_mapping       = 0
    let g:EasyMotion_keys             = 'abcdefghijklmnopqrstuvwxyz'
    let g:EasyMotion_grouping         = 1
    let g:EasyMotion_smartcase        = 1
    let g:EasyMotion_startofline      = 0
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_space_jump_first = 1

    nnoremap <easymotion> <nop>
    nmap     S            <easymotion>

    nmap <easymotion>j <Plug>(easymotion-s2)
    xmap <easymotion>j <Plug>(easymotion-s2)
    nmap <easymotion>/ <Plug>(easymotion-sn)
    xmap <easymotion>/ <Plug>(easymotion-sn)
    map  <easymotion>k <Plug>(easymotion-bd-jk)
    nmap <easymotion>k <Plug>(easymotion-overwin-line)
    map  <easymotion>S <Plug>(easymotion-bd-w)
    nmap <easymotion>S <Plug>(easymotion-overwin-w)
    map  <easymotion>w <Plug>(easymotion-bd-w)
    nmap <easymotion>w <Plug>(easymotion-overwin-w)
endif

" ----> terryma/vim-multiple-cursors
if s:has_plug('vim-multiple-cursors')
    let g:multi_cursor_use_default_mapping = 0

    nnoremap <multiple-cursors> <nop>
    nmap     C                  <multiple-cursors>

    let g:multi_cursor_start_word_key      = 'C'
    let g:multi_cursor_select_all_word_key = '<leader>C'
    let g:multi_cursor_start_key           = 'gC'
    let g:multi_cursor_select_all_key      = 'g<leader>C'
    let g:multi_cursor_next_key            = '<c-n>'
    let g:multi_cursor_prev_key            = '<c-p>'
    let g:multi_cursor_skip_key            = '<c-x>'
    let g:multi_cursor_quit_key            = '<esc>'
endif

" ----> dhruvasagar/vim-table-mode
if s:has_plug('vim-table-mode')
    let g:table_mode_corner = '|'
endif

" ----> liuchengxu/vista.vim
if s:has_plug('vista.vim')
    let g:vista_sidebar_position         = 'vertical botright'
    let g:vista_sidebar_width            = 30
    let g:vista_echo_cursor              = 1
    let g:vista_cursor_delay             = 400
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        let g:vista_echo_cursor_strategy = 'floating_win'
    else
        let g:vista_echo_cursor_strategy = 'echo'
    endif
    let g:vista_close_on_jump            = 0
    let g:vista_stay_on_open             = 1
    let g:vista_blink                    = [2, 100]
    let g:vista_icon_indent              = ['╰─▸ ', '├─▸ ']
    let g:vista_default_executive        = 'ctags'
    let g:vista#executives               = ['ctags', 'coc']
    let g:vista_ctags_cmd                = {
          \ 'haskell': 'hasktags -o - -c',
          \ }
    let g:vista_fzf_preview              = ['right:50%']
    let g:vista_disable_statusline       = 0
    let g:vista#renderer#enable_icon     = 0
    let g:vista_no_mappings              = 0

    augroup Vista
        autocmd!
        autocmd FileType *          nmap <s-t> :Vista coc<cr>
        autocmd FileType markdown   nmap <s-t> :Vista toc<cr>
    augroup END
endif

" ----> junegunn/fzf.vim
if s:has_plug('fzf.vim')
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
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!{'.shellescape(&wildignore).'}"'
    endif

    nnoremap <silent> <space>ff :FZFFiles<cr>
    nnoremap <silent> <space>fb :FZFBuffers<cr>
    nnoremap <silent> <space>fh :FZFHistory<cr>
    nnoremap <silent> <space>fc :FZFHistory:<cr>
    nnoremap <silent> <space>fs :FZFHistory/<cr>
    nnoremap <silent> <space>fg :FZFGFiles?<cr>
    nnoremap <silent> <space>ft :FZFBTags<cr>
    nnoremap <silent> <space>fr :FZFRg<cr>

    command! -bar -bang FZFMapsN call fzf#vim#maps("n", <bang>0)
    command! -bar -bang FZFMapsI call fzf#vim#maps("i", <bang>0)
    command! -bar -bang FZFMapsX call fzf#vim#maps("x", <bang>0)
    command! -bar -bang FZFMapsO call fzf#vim#maps("o", <bang>0)
    command! -bar -bang FZFMapsV call fzf#vim#maps("v", <bang>0)
endif

" ----> mbbill/undotree
if s:has_plug('undotree')
    nnoremap <silent> <s-u> :UndotreeToggle<cr>
endif

" ----> cohama/lexima.vim
if s:has_plug('lexima.vim')
    function! s:lexima_custom_rules() abort
        call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': ['markdown', 'plaintex', 'latex', 'tex']})
        call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': ['markdown', 'plaintex', 'latex', 'tex']})
        call lexima#add_rule({'char': '$', 'at': '^\$\%#\$$', 'input_after' : '<CR>$', 'filetype': ['markdown']})
        call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': ['markdown', 'plaintex', 'latex', 'tex']})
        call lexima#add_rule({'char': '<BS>', 'at': '^\$\$\%#\n\$\$$', 'input': '<BS><BS>', 'delete': 3, 'filetype' : ['markdown']})
    endfunction
    augroup Lexima
        autocmd!
        autocmd FileType scheme let b:lexima_disabled = 1
        autocmd VimEnter * call s:lexima_custom_rules()
    augroup END
endif

" ----> neoclide/coc.nvim
if s:has_plug('coc.nvim')
    if &backup || &writebackup
        set nobackup
        set nowritebackup
    endif
    let g:coc_disable_startup_warning = 1
    let g:coc_global_extensions       = [
        \ 'coc-word',
        \ 'coc-emoji',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-json',
        \ 'coc-yaml',
        \ 'coc-toml',
        \ 'coc-tsserver',
        \ 'coc-prettier',
        \ 'coc-pyright',
        \ 'coc-rust-analyzer',
        \ 'coc-clangd',
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
    if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
    else
        inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
    nnoremap <silent> K :call <SID>show_documentation()<CR>

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
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        autocmd FileType scss setl iskeyword+=@-@
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
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

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <coc>v <Plug>(coc-range-select)
    xmap <silent> <coc>v <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call   CocAction('fold', <f-args>)
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call   CocAction('runCommand', 'editor.action.organizeImport')

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <coc>d :<C-u>CocDiagnostics<cr>
    nnoremap <silent><nowait> <coc>D :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <coc>e :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <coc>c :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <coc>o :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <coc>s :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <coc>j :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <coc>k :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <coc>p :<C-u>CocListResume<CR>

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

" ----> dense-analysis/ale
if s:has_plug('ale')
    let g:ale_command_wrapper      = 'nice -n5'
    let g:ale_maximum_file_size    = 10 * 1024 * 1024
    let g:ale_echo_msg_error_str   = 'E'
    let g:ale_echo_msg_info_str    = 'I'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_log_str     = 'L'
    let g:ale_echo_msg_format      = '%severity%: [%linter%] %s'
    let g:ale_loclist_msg_format   = '[%linter%] %code: %%s'
    let g:ale_sign_error           = '>>'
    let g:ale_sign_warning         = '--'
    let g:ale_sign_info            = '~~'
    let g:ale_set_quickfix         = 1
    let g:ale_list_window_size     = 6
    let g:ale_open_list            = 'on_save'
    let g:ale_fix_on_save          = 1
    let g:ale_fixers               = {
        \ 'go': ['goimports'],
        \ 'python': ['black'],
        \ 'rust': ['rustfmt']
    \}
    let g:ale_lint_delay           = 1000
    let g:ale_linters_explicit     = 1
    let g:ale_linters              = {
        \ 'c': ['gcc'],
        \ 'cpp': ['gcc'],
        \ 'go': ['golint', 'go vet'],
        \ 'java': ['javac'],
        \ 'lua': ['luac'],
        \ 'python': ['flake8', 'pylint'],
        \ 'rust': ['cargo', 'rls'],
        \ 'sh': ['shell']
    \ }

    nmap <silent> [a <Plug>(ale_previous)
    nmap <silent> ]a <Plug>(ale_next)
    nmap <silent> [A <Plug>(ale_first)
    nmap <silent> ]A <Plug>(ale_last)

    highlight clear ALEErrorSign
    highlight clear ALEWarningSign
endif

" ----> fatih/vim-go
if s:has_plug('vim-go')
    let g:go_version_warning               = 0
    let g:go_code_completion_enabled       = 0
    let g:go_updatetime                    = 0
    let g:go_jump_to_error                 = 0
    let g:go_fmt_autosave                  = 0
    if has('patch-8.2.0012') || has('nvim')
        let g:go_doc_popup_window          = 1
    endif
    let g:go_def_mapping_enabled           = 0
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
        autocmd FileType go nmap <s-d>     :GoDoc <c-r>=expand('<cword>')<cr><cr>
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
if s:has_plug('rust.vim')
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
    highlight Normal     ctermbg=0 guibg=#000000
    highlight LineNr     ctermbg=0 guibg=#000000
    highlight VertSplit  ctermfg=0 guifg=#000000
    highlight SignColumn ctermbg=0 guibg=#000000
endfunction

augroup Highlights
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

" ----> Color
silent! colorscheme PaperColor

" ----> Key maps
let mapleader      = ','    " set vim map leader, <leader>
let maplocalleader = '\'    " set vim local map leader, <localleader>

" Buffer switching
nnoremap <silent> [b    :bprevious<cr>
nnoremap <silent> ]b    :bnext<cr>
nnoremap <silent> [B    :bfirst<cr>
nnoremap <silent> ]B    :blast<cr>
nnoremap <silent> <c-q> :bdelete<cr>

" Tab switching
nnoremap <silent> [t :tabprevious<cr>
nnoremap <silent> ]t :tabnext<cr>
nnoremap <silent> [T :tabfirst<cr>
nnoremap <silent> ]T :tablast<cr>
nnoremap <silent> <c-t> :tabnew<cr>
inoremap <silent> <c-t> <esc>:tabnew<cr>

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
nnoremap <c-H> <c-w>h
nnoremap <c-J> <c-w>j
nnoremap <c-K> <c-w>k
nnoremap <c-L> <c-w>l
inoremap <c-H> <esc><c-w>h
inoremap <c-J> <esc><c-w>j
inoremap <c-K> <esc><c-w>k
inoremap <c-L> <esc><c-w>l

" Window switching in terminal mode
if has('terminal')
    tnoremap <c-H> <c-w>h
    tnoremap <c-J> <c-w>j
    tnoremap <c-K> <c-w>k
    tnoremap <c-L> <c-w>l
    tnoremap <silent> <c-q> <c-w>:q!<cr>
endif

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Search will center on the line it's found in
nnoremap n nzzzv
nnoremap N Nzzzv

" Move visual block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Search in selected visual block
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" Fast save
noremap  <silent> <c-s> :update<cr>
inoremap <silent> <c-s> <esc>:update<cr>

" Move vertically by visual line
noremap  <silent> <expr> j v:count ? 'j' : 'gj'
noremap  <silent> <expr> k v:count ? 'k' : 'gk'
vnoremap <silent> <expr> j v:count ? 'j' : 'gj'
vnoremap <silent> <expr> k v:count ? 'k' : 'gk'

" Toggle spell check for en_us
nnoremap <silent> <leader>s :setlocal spell! spelllang=en_us<cr>

" Switch to working directory of the open file
nnoremap <leader>cd :<c-u>lcd %:p:h<cr>:pwd<cr>

" Turn off search highlight
nnoremap <silent> <space>n :nohlsearch<cr>

" Open terminal on the right
nnoremap <silent> <space>t :terminal<cr><c-w>L

" Hex read
nnoremap <silent> <space>hr :%!xxd<cr> :set filetype=xxd<cr>
" Hex write
nnoremap <silent> <space>hw :%!xxd -r<cr> :set binary<cr> :set filetype=<cr>

" Map w!! to write file with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Toggle displaying non-printable characters
nnoremap <silent> <space>l :set list!<cr>

" Toggle soft-wrap
nnoremap <silent> <space>w :set wrap! wrap?<cr>

" Rotate tab size
nnoremap <silent> <space>v :let &ts=(&ts*2 > 16 ? 2 : &ts*2)<cr>:echo "tabstop:" . &ts<cr>

" Reselect the text that has just been pasted
nnoremap <silent> <space>p `[V`]

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

" ----> Tricks
augroup VimTricks
    autocmd!
    " switch to working directory of the open file
    " autocmd BufEnter    * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
    " trim trailing whitespace on write
    autocmd BufWritePre * :%s/\s\+$//e
    " remember cursor position
    autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
    " close the quickfix or locationlist window when exiting
    autocmd QuitPre     * if empty(&buftype) | cclose | lclose | endif
augroup END

" ----> Netrw
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
noremap <silent> <s-f> :call NetrwToggle()<cr>

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
