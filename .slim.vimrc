" Tarrex's vimrc
"       ------ Enjoy vim, enjoy coding.

" ============> Prepare <============
let s:env          = {}
let s:env.windows  = has('win64') || has('win32')
let s:env.cygwin   = has('win32unix')
let s:env.mac      = has('unix') && has('mac') || has('macunix') || system('uname') =~? '^darwin'
let s:env.linux    = has('unix') && has('linux')
let s:env.unix     = has('unix') && !s:env.mac && !s:env.linux

let s:env.starting = has('vim_starting')
let s:env.gui      = has('gui_running')

if s:env.windows
    let s:vimdir = $HOME . '/vimfiles'
else
    let s:vimdir = $HOME . '/.vim'
endif

" ============> General <============
if &compatible
    set nocompatible                    " be iMproved, required
endif

syntax on                               " syntax highlighting
filetype indent plugin on               " filetype detection on

set number                              " print the line number in front of each line
set noruler                             " don't show the line and column number of the cursor position, separated by a comma
set nowrap                              " don't wrap lines longer than the width of the window
set nomodeline                          " don't allow setting options via buffer content
set showcmd                             " show (partial) command in the last line of the screen
set noshowmatch                         " don't briefly jump to the matching one when a bracket is inserted
set noshowmode                          " don't display Insert, Replace or Visual mode message on the last line
set linebreak                           " break lines at word boundaries
set laststatus=2                        " show status line
set display=lastline                    " as much as possible of the last line in a window will be displayed
if getfsize(@%) < 10 * 1024 * 1024      " if file size more than 10MB, don't show cursorline and cursorcolumn
    set cursorline                      " show underline for the cursor's line
    silent! set cursorlineopt=number    " highlight the line number of the cursor if could
endif
silent! set signcolumn=number           " display signs in the 'number' column if could else 'auto'
set background=dark                     " try to use colors that look good on a dark background
silent! set termguicolors               " enable GUI colors for the terminal to get truecolor

set expandtab                           " covert tabs to spaces, insert real tab by ctrl-v<tab> if you want
set shiftround                          " round indent to multiple of 'shiftwidth'
set shiftwidth=4                        " number of spaces to use for each step of (auto)indent
set tabstop=4                           " number of spaces that a <tab> in the file counts for
set softtabstop=4                       " number of spaces that a <tab> counts for while performing editing operations
set smarttab                            " be smart when use tabs
set autoindent                          " copy indent from current line when starting a new line
set breakindent                         " every wrapped line will continue visually indented

set hlsearch                            " highlight all search pattern results
set ignorecase                          " ignore case in search patterns.
set incsearch                           " real time show the search case
set smartcase                           " override the 'ignorecase' option if the search pattern contains upper case characters
if executable('rg')
    let &grepprg='rg --vimgrep'         " rg as the program to call when using the Ex commands: `:[l]grep[add]`
    set grepformat=%f:%l:%c:%m,%f:%l:%m " how the output of rg must be parsed
endif

set encoding=utf-8                      " the character encoding used inside vim
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,latin1 " list of character encodings considered when starting to edit an existing file
set fileformats=unix,dos,mac            " gives the <eol> formats of editing a new buffer or reading a file
silent! set termencoding=utf-8          " encoding used for the terminal

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
set ttymouse=sgr                        " name of the terminal type for which mouse codes are to be recognized, necessary when running vim in tmux
set clipboard=autoselect,exclude:.*     " enable clipboard with system
set scrolloff=1                         " minimal number of screen lines to keep above and below the cursor
set sidescroll=5                        " minimal number of columns to scroll horizontally
set sidescrolloff=1                     " minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
silent! set termwinkey=<c-w>            " the key that starts a CTRL-W command in a terminal window

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
set completeopt=menu,menuone            " use a popup menu to show the possible completions even if there is only one match
silent! set completeopt+=noselect       " only insert the longest common text of the matches
silent! set completeopt+=popup          " add popup option for insert mode completion if could
silent! set completepopup=border:off    " used for the properties of the info popup when it is created
set diffopt+=context:3                  " only 3 lines of context above/below a changed line (instead of 6)
set diffopt+=vertical                   " start diff mode with vertical splits (unless explicitly specified otherwise)
set diffopt+=foldcolumn:1               " use only 1 column for the foldcolumn, instead of 2 (vertical space is precious)
silent! set diffopt+=hiddenoff          " turn off diff mode automatically for a buffer which becomes hidden
silent! set diffopt+=indent-heuristic   " use the indent heuristic for the internal diff library
silent! set diffopt+=algorithm:patience " use the `patience` diff algorithm
set formatoptions+=m                    " also break at a multibyte character above 255, useful for asian text where every character is a word on its own
set formatoptions+=B                    " when joining lines, don't insert a space between two multibyte characters
set formatoptions+=j                    " remove a comment leader when joining lines
set nrformats-=octal                    " treat numbers with a leading zero as decimal, not octal
set shortmess+=a                        " enable all sort of abbreviations
set shortmess+=c                        " don't give ins-completion-menu messages
set shortmess-=S                        " helps to avoid all the hit-enter prompts caused by file messages
silent! set spelloptions=camel          " when a word is CamelCased, assume "Cased" is a separate word
set fillchars=vert:┃                    " vertical separators
set listchars=eol:¬                     " end of line
set listchars+=extends:»                " unwrapped text to screen right
set listchars+=precedes:«               " unwrapped text to screen left
silent! set listchars+=tab:<->          " tab characters, preserve width
set listchars+=nbsp:∅                   " non-breaking spaces
set breakat+=)]}                        " line break characters, default are ' ^I!@*-+;:,./?'
let &showbreak = '↪ '                   " string to put at the start of lines that have been wrapped
set virtualedit=block                   " allow virtual editing in Visual block mode
set whichwrap=b,s,h,l,<,>,[,]           " allow specified keys that move the cursor left/right to move to the previous/next line when the cursor is on the first/last character in the line

set dictionary+=/usr/share/dict/words   " files that are used to lookup words for keyword completion commands
set path=.,**5                          " look in the directory of the current buffer non-recursively, and in the working directory recursively
set tags=./tags;                        " filenames for the tag command, file in the directory of the CURRENT FILE, then in its parent directory, then in the parent of the parent its parent directory, then in the parent of the parent
set noswapfile                          " don't create swapfile for the buffer
" let &directory = s:vimdir . '/tmp/swap'
" if !isdirectory(&directory)
"     silent call mkdir(&directory, 'p', 0700)
" endif
set backup                              " make a backup before overwriting a file
set backupext=.bak                      " string which is appended to a file name to make the name of the backup file
set backupskip+=/etc/cron.*/*           " list of file patterns that do not create backup file
let &backupdir = s:vimdir . '/tmp/backup'
if !isdirectory(&backupdir)
    silent call mkdir(&backupdir, 'p', 0700)
endif
set undofile                            " automatically saves undo history to an undo file
set undolevels=1000                     " maximum number of changes that can be undone
let &undodir = s:vimdir . '/tmp/undo'
if !isdirectory(&undodir)
    silent call mkdir(&undodir, 'p', 0700)
endif
set viminfo='100,:1000,<50,s10,h,!      " viminfo settings
if has('nvim')
    let &viminfo.=',n' . s:vimdir . '/nviminfo'
else
    let &viminfo.=',n' . s:vimdir . '/viminfo'
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

" ============> Simple <============
" mode map
let g:currentmode = {
    \ 'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE',
    \ 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
    \ 'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE',
    \ "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
\ }

" file name
function! FileName() abort
    if winwidth(0) < 50
        let fname = expand('%:t')
    elseif winwidth(0) > 150
        let fname = expand('%')
    else
        let fname = pathshorten(expand('%'))
    endif
    return &ft ==? 'netrw' ? '' :
        \ &ft ==? 'qf' ? '' :
        \ ('' !=? fname ? fname : '[No Name]') .
        \ (&modified ? ' +' : '')
endfunction

" file size
function! FileSize() abort
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

" statusline
function! Statusline() abort
    if &previewwindow | return | endif
    let line  = ''
    " let line .= ' %{mode()} '                        " buffer mode
    let line .= ' %{g:currentmode[mode()]} '         " buffer mode
    let line .= '%{&paste!=#"paste"? "| paste ":""}' " paste state
    let line .= '| %n '                              " buffer number
    let line .= '%{&ro!=#""?"| RO ":""}'             " read only flag
    let line .= '| %{FileName()} '                   " tail of filename
    let line .= ' %= '                               " separator
    let line .= '%{FileSize()} '                     " file size
    let line .= '| %{&ff} '                          " file format
    let line .= '| %{&fenc?&fenc:&enc} '             " file encoding
    let line .= '| %{&ft!=#""?&ft:"no ft"} '         " filetype
    let line .= '| %3p%% '                           " percent through file
    let line .= '| %3l:%-2v '                        " cursor column
    return line
endfunction

let &statusline = Statusline()

" complete
augroup Complete
    autocmd!
    autocmd CursorMovedI  if pumvisible() == 0 | pclose | endif
    autocmd InsertLeave   if pumvisible() == 0 | pclose | endif
    autocmd FileType *
        \ if &omnifunc == '' |
        \     setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup END

inoremap <expr><CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr><Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr><PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
inoremap <expr><TAB>      pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>    pumvisible() ? "\<C-p>" : "\<S-TAB>"

" insert pairs
inoremap <c-x>( ()<esc>i
inoremap <c-x>[ []<esc>i
inoremap <c-x>' ''<esc>i
inoremap <c-x>" ""<esc>i
inoremap <c-x>< <><esc>i
inoremap <c-x>` ``<esc>i
inoremap <c-x>$ $$<esc>i
inoremap <c-x>{ {<esc>o}<esc>ko

" grep
function! Grep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup MyQuickFix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" pack
if !exists('g:loaded_matchit')
    silent! packadd matchit
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

    highlight StatusLine       ctermbg=247 ctermfg=234 guibg=#9e9e9e guifg=#1c1c1c
    highlight StatuslineNC     ctermbg=247 ctermfg=234 guibg=#9e9e9e guifg=#1c1c1c
    highlight StatuslineTerm   ctermbg=247 ctermfg=234 guibg=#9e9e9e guifg=#1c1c1c
    highlight StatuslineTermNC ctermbg=247 ctermfg=234 guibg=#9e9e9e guifg=#1c1c1c
    highlight Pmenu            ctermbg=8   ctermfg=0   guibg=#808080 guifg=#000000
    highlight PmenuSel         ctermbg=36  ctermfg=0   guibg=#00af87 guifg=#000000
    highlight PmenuSbar        ctermbg=7   ctermfg=15  guibg=#c0c0c0 guifg=#ffffff
    highlight PmenuThumb       ctermbg=15  ctermfg=7   guibg=#ffffff guifg=#c0c0c0
endfunction

augroup Highlights
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

" ----> Color
silent! colorscheme desert

" ----> Key maps
let g:mapleader      = ','              " set vim map leader, <leader>
let g:maplocalleader = '\'              " set vim local map leader, <localleader>

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
nnoremap <silent> [t :tabprevious<cr>
nnoremap <silent> ]t :tabnext<cr>
nnoremap <silent> [T :tabfirst<cr>
nnoremap <silent> ]T :tablast<cr>
nnoremap <silent> <c-t> :tabnew<cr>
inoremap <silent> <c-t> <esc>:tabnew<cr>
nnoremap <silent> tt :<c-u>call MoveToTab()<cr>
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
nnoremap <silent> <space>t :terminal<cr><c-w>L

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
augroup CustomFileType
    autocmd!
    autocmd FileType qf setl nonu nornu
augroup END

" ----> Tricks
augroup VimTricks
    autocmd!
    " trim trailing whitespace on write
    autocmd BufWritePre * let b:pos=getpos('.') | %s/\s\+$//e | call setpos('.', b:pos)
    " remember cursor position
    autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
    " close the quickfix or locationlist window when exiting
    autocmd QuitPre     * if empty(&buftype) | cclose | lclose | endif
    " auto source $MYVIMRC
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" ----> Commands
command! RemoveBlankLine silent! g/^$/d | nohlsearch | normal! ``
command! -bar RTP echo substitute(&runtimepath, ',', "\n", 'g')
command! -nargs=* -complete=mapping AllMaps map <args> | map! <args> | lmap <args>

" ----> Disable some vim built-in plugins
let g:loaded_2html_plugin    = 1        " tohtml
let g:loaded_getscriptPlugin = 1        " getscript
let g:loaded_logiPat         = 1        " logipat
let g:loaded_vimballPlugin   = 1        " vimball interface
let g:loaded_vimball         = 1        " vimball autoload

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
if s:env.windows
    nnoremap <leader>e :!start explorer /e,%:p:h \| redraw!<cr>
    nnoremap <leader>E :execute "!start explorer /e," . shellescape(getcwd(),1) \| redraw!<cr>
elseif s:env.mac
    nnoremap <leader>e :silent execute '![ -f "%:p" ] && open -R "%:p" \|\| open "%:p:h"' \| redraw!<cr>
    nnoremap <leader>E :silent execute '!open .' \| redraw!<cr>
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

set secure                              " ':autocmd', shell and write commands are not allowed in '.vimrc' and '.exrc' in the current directory and map commands are displayed