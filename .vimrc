" Tarrex's vimrc
"       ------ Enjoy vim, enjoy coding.

" ============> General <============

let s:vimdir = $HOME . '/.vim'  " vim config directory

if &compatible
    set nocompatible            " be iMproved, required
endif

syntax on                       " syntax highlighting
filetype indent plugin on       " filetype detection on

set number                      " print the line number in front of each lin
set ruler                       " show the line and column number of the cursor position, separated by a comma
set wrap                        " wrap lines longer than the width of the window

let s:bytes = getfsize(@%)
if s:bytes < 10 * 1024 * 1024   " 10MB
    set cursorline              " show underline for the cursor's line
    set cursorlineopt=number
    " set cursorcolumn            " show column line for the cursor's column
else
    set nocursorline
    set nocursorcolumn
endif

set expandtab                   " covert tabs to spaces, insert real tab by ctrl-v<tab> if you want
set shiftround                  " round indent to multiple of 'shiftwidth'
set shiftwidth=4                " number of spaces to use for each step of (auto)indent
set tabstop=4                   " number of spaces that a <tab> in the file counts for
set softtabstop=4               " number of spaces that a <tab> counts for while performing editing operations
set smarttab                    " be smart when use tabs

set autoindent                  " copy indent from current line when starting a new line
set breakindent                 " every wrapped line will continue visually indented

if has('multi_byte')
    set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1 " list of character encodings considered when starting to edit an existing file
    set encoding=utf-8          " the character encoding used inside vim
    set fileencoding=utf-8      " the character encoding for the file of this buffer
endif
set fileformat=unix             " gives the <eol> of the current buffer
set fileformats=unix,dos,mac    " gives the <eol> formats of editing a new buffer or reading a file

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

set splitbelow                  " horizontally split below
set splitright                  " vertically split to the right
set noequalalways               " all the windows are automatically made the same size after splitting or closing a window

set pastetoggle=<F4>            " set paste toggle

set background=dark             " try to use colors that look good on a dark background
if has('termguicolors')
    set termguicolors           " enable GUI colors for the terminal to get truecolor
endif

set noswapfile                  " don't create swapfile for the buffer
let &backupdir = s:vimdir . '/tmp'
if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p', 0755)
    set backup                              " make a backup before overwriting a file
    set backupext=.bak                      " string which is appended to a file name to make the name of the backup file
    set backupskip+=/etc/cron.*/*           " list of file patterns that do not create backup file
endif
if has('persistent_undo')
    let &undodir = s:vimdir . '/undodir'    " list of directory names for undo files, separated with commas
    if !isdirectory(&undodir)
        call mkdir(&undodir, 'p', 0755)
    endif
    set undofile                            " automatically saves undo history to an undo file
    set undolevels=1000                     " maximum number of changes that can be undone
endif

set viminfo='100,:10000,<50,s10,h,!         " viminfo settings
let &viminfo.=',n' . s:vimdir . '/viminfo'  " viminfo file location
set history=10000                           " set how many lines of command history vim has to remember

let &errorfile = s:vimdir . '/error'        " name of the errorfile for the quickfix mode

set dictionary+=/usr/share/dict/words       " files that are used to lookup words for keyword completion commands

if has("patch-8.1.1564")
    set signcolumn=number       " display signs in the 'number' column
else
    set signcolumn=yes          " always display signs
endif
set comments=                   " clear default comments value, let the filetype handle it
set include=                    " don't assume I'm editing C; let the filetype set this
set nrformats-=octal            " treat numbers with a leading zero as decimal, not octal
set formatoptions+=j            " delete comment leaders when joining lines, if supported
set shortmess-=S                " helps to avoid all the hit-enter prompts caused by file messages
set shortmess+=c                " don't give ins-completion-menu messages
set laststatus=2                " show status line
set display=lastline            " as much as possible of the last line in a window will be displayed
set scrolloff=1                 " minimal number of screen lines to keep above and below the cursor
set nojoinspaces                " don't insert two spaces after a '.', '?' and '!' with a join command
set matchpairs=(:),{:},[:],《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:” " characters that form pair, % command jumps to the other
set showmatch                   " show the match pairs  can be seen on the screen
set nomodeline                  " don't allow setting options via buffer content
set breakat=                    " line break character ' ', default are ' ^I!@*-+;:,./?'
set linebreak                   " break lines at word boundaries
set visualbell t_vb=            " no beep or flash is wanted

set nolist                      " don't display non-printable characters
set listchars+=extends:>        " unwrapped text to screen right
set listchars+=precedes:<       " unwrapped text to screen left
set listchars+=tab:>-           " tab characters, preserve width
set listchars+=trail:_          " trailing spaces
set listchars+=nbsp:+           " non-breaking spaces

set completeopt+=popup,longest,menuone  " list of options for Insert mode completion
set completepopup=border:off            " used for the properties of the info popup when it is created

set diffopt+=vertical,context:3,foldcolumn:0 " option settings for diff mode
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
set wildignore+=*.avi,*.mp[4v],*.m[4k]v,*.f[4l]v,*.rm,*.rmvb,*.ts,*.wmv
set wildignore+=*.aac,*.ape,*.flac,*.mp3,*.ogg,*.wav,*.wma,*.webm
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf,*.azw*,*.xps
set wildignore+=*.ppt*,*.doc*,*.xls*,*.od[tspg],*.pages,*.numbers,*.key,*.wps
set wildignore+=*.msi,*.exe,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*/node_modules/**,*/nginx_runtime/**,*/build/**,*/logs/**
set wildignore+=*/dist/**,*/tmp/**,*/.Trash/**,*/.rbenv/**
set wildignore+=.git,*.git,.svn,.idea,.vscode,.vim
set wildignore+=*DS_Store,*Thumbs.db

" ============> Plugins <============
let s:coc = expand(s:vimdir . '/coc-settings.json')
let s:vimplug = expand(s:vimdir . '/autoload/plug.vim')
if !filereadable(s:coc) || !filereadable(s:vimplug)
    if !executable('curl')
        echoerr 'You have to install curl or first install vim-plug yourself!'
        exe 'q!'
    endif
    if !filereadable(s:coc)
        if !executable('yarn') && !executable('npm')
            echoerr 'You have to install yarn/npm for coc.nvim plugin later!'
            echo ''
        endif
        echo 'Download coc-settings.json...'
        echo ''
        silent exe '!curl -fLo ' . s:coc . ' --create-dirs https://tarrex.github.io/dotfiles/coc-settings.json'
    endif
    if !filereadable(s:vimplug)
        echo 'Installing Vim-Plug...'
        echo ''
        silent exe '!curl -fLo ' . s:vimplug . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd! VimEnter * PlugInstall
    endif
endif

call plug#begin(s:vimdir . '/plugged')

Plug 'chriskempson/base16-vim'
Plug 'vim-scripts/ScrollColors'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mbbill/undotree'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for': 'go'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}

call plug#end()

" ----> itchyny/lightline.vim
let g:lightline = {
    \ 'enable': {
    \   'statusline': 1,
    \   'tabline': 0
    \ },
    \ 'colorscheme': 'materia',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'bufnum' ],
    \           [ 'gitbranch', 'readonly', 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'linter', 'fileformat', 'fileencoding', 'filetype', 'filesize' ],
    \            [ 'tagbar' ],
    \            [ 'blame' ] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'filename' ]],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ]]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'linter': 'LightlineLinter',
    \   'gitbranch': 'LightlineGitBranch',
    \   'blame': 'LightlineGitBlame',
    \   'filesize': 'LightlineFileSize'
    \ },
    \ 'component': {
    \   'tagbar': '[%{tagbar#currenttagtype("%s", "")}: %{tagbar#currenttag("%s", "", "f")}]'
    \ }
\ }

function! LightlineFilename() abort
    let filename = expand('%:p:~') !=# '' ? expand('%:p:~') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

function! LightlineFileSize() abort
    let l:bytes = getfsize(@%)
    if l:bytes <= 0
        return '0B'
    endif
    " let l:units = 'BKMGT'
    " let l:fsize = ''
    " let l:idx = 0
    " while l:bytes > 0 && len(l:units) > 0 && l:idx < 5
    "     let l:fsize = l:bytes % 1024 . l:units[l:idx] . l:fsize
    "     let l:idx += 1
    "     let l:bytes /= 1024
    " endwhile
    " return l:fsize
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1024
    endif
    if exists('l:kbytes') && l:kbytes >= 1024
        let l:mbytes = l:kbytes / 1024
    endif
    if exists('l:mbytes') && l:mbytes >= 1024
        let l:gbytes = l:mbytes / 1024
    endif
    if exists('l:gbytes')
        return l:gbytes . 'G'
    elseif exists('l:mbytes')
        return l:mbytes . 'M'
    elseif exists('l:kbytes')
        return l:kbytes . 'K'
    else
        return l:bytes . 'B'
    endif
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

" ----> majutsushi/tagbar
noremap <silent> <s-t> :TagbarToggle<cr>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
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

" ----> mbbill/undotree
nnoremap <silent> <s-u> :UndotreeToggle<cr>

" ----> neoclide/coc.nvim
if &backup || &writebackup
    set nobackup
    set nowritebackup
endif
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
    \ 'coc-vimlsp',
    \ 'coc-clangd',
    \ 'coc-graphql',
    \ 'coc-cmake'
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

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ----> fatih/vim-go
let g:go_version_warning = 0
let g:go_code_completion_enabled = 0
let g:go_jump_to_error = 0
let g:go_fmt_autosave = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0
let g:go_echo_command_info = 0
let g:go_echo_go_info = 0
let g:go_addtags_transform = 'camelcase'
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_diagnostic_errors = 0
 let g:go_highlight_diagnostic_warnings = 0
augroup Go
    autocmd!
    autocmd FileType go nmap <c-g> :GoDeclsDir<cr>
    autocmd FileType go imap <c-g> <esc>:<c-u>GoDeclsDir<cr>
    autocmd FileType go nmap <leader>gr :GoRun<cr>
    autocmd FileType go nmap <leader>gt :GoTestFunc<cr>
    autocmd FileType go nmap <leader>gc :GoCovergeToggle!<cr>
    autocmd FileType go nmap <leader>gp :GoChannelPeers<cr>
    autocmd FileType go nmap <leader>gs :GoSameIdsToggle<cr>
    autocmd FileType go nmap <leader>gi :GoPointsTo<cr>
    autocmd FileType go nmap <leader>ta :GoAddTags<cr>
    autocmd FileType go nmap <leader>tr :GoRemoveTags<cr>
    autocmd FileType go nmap <leader>gf :GoFillStruct<cr>
    autocmd FileType go nmap <leader>ge :GoIfErr<cr>
augroup END

" ----> rust-lang/rust.vim
augroup Rust
    autocmd!
    autocmd FileType rust nmap <leader>rb :Cbuild<cr>
    autocmd FileType rust nmap <leader>rr :Crun<cr>
augroup END

" ============> Custom <============

" ----> Color
silent! colorscheme base16-materia

" ----> Highlights
" Highlight some special strings
highlight ToDo cterm=bold term=bold ctermbg=yellow ctermfg=black
match ToDo /\(TODO\)/
augroup hilightSpecialStrings
    autocmd!
    autocmd WinEnter * match ToDo /\(TODO\)/
augroup END

" Some custom highlights
highlight Normal guibg=black ctermbg=black
highlight LineNr guibg=black ctermbg=black
highlight SignColumn guibg=black ctermbg=black

" ----> Keyboard
let mapleader = ','     " set vim map leader
let g:mapleader = ','

nnoremap <silent> <space>n :nohlsearch<cr>  " turn off search highlight

nnoremap <leader>tc :tabclose<cr>           " close tab
nnoremap <leader>tn :tabnext<cr>            " go to next tab
nnoremap <leader>tp :tabprevious<cr>        " go to previous tab
nnoremap <leader>te :tabnew<cr>             " create new tab

nnoremap <leader>bp :bprevious<cr>          " go to previous buffer
nnoremap <leader>bn :bnext<cr>              " go to next buffer
nnoremap <leader>bd :bdelete<cr>            " close the current buffer
nnoremap <leader>bl :buffers<cr>            " list buffers
nnoremap <leader>bg :buffer                 " go to given buffer number

nnoremap <silent> <leader>s :setlocal spell! spelllang=en_us<cr>   " set spell shortcut

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

nnoremap <silent> <space>t :terminal<cr><c-w>L

" Hex read
nmap <silent> <space>hr :%!xxd<cr> :set filetype=xxd<cr>
" Hex write
nmap <silent> <space>hw :%!xxd -r<cr> :set binary<cr> :set filetype=<cr>

" Map w!! to write file with sudo
cmap w!! w !sudo tee % >/dev/null

" Toggle displaying non-printable characters
nnoremap <silent> <space>l :set list!<cr>

" Toggle soft-wrap
nnoremap <silent> <space>w :set wrap! wrap?<cr>

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

" Close the quickfix or locationlist window when exiting
autocmd! QuitPre * if empty(&buftype) | cclose | lclose | endif

" ----> Netrw
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_list_hide = &wildignore
function! NetrwToggle() abort
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
noremap <silent> <s-f> :call NetrwToggle()<cr>

" ----> Zen mode
let s:zen_mode=0
function! ZenModeToggle() abort
    if s:zen_mode==0
        let s:zen_mode=1
        set nosmd noru nosc nonu ls=0
        syntax off
        highlight Normal guifg=LightGrey ctermfg=LightGrey guibg=black ctermbg=black
    else
        let s:zen_mode=0
        set smd ru sc nu ls=2
        highlight clear Normal
        syntax on
    endif
endfunction
nnoremap <silent> <space>z :call ZenModeToggle()<cr>

" ----> View changes after the last save
function! DiffWithSaved() abort
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    exe "normal! ]c"
endfunction
nnoremap <silent> <space>d :call DiffWithSaved()<cr>

" ----> Toggle Quickfix / LocationList window
function! QuickfixToggle() abort
    if len(filter(getwininfo(), 'v:val.quickfix'))
        cclose
    else
        copen 6
    endif
endfunction
nnoremap <silent> <space>, :call QuickfixToggle()<cr>

function! LocationToggle() abort
    if len(filter(getwininfo(), 'v:val.loclist'))
        lclose
    else
        lopen 6
    endif
endfunction
nnoremap <silent> <space>. :call LocationToggle()<cr>
