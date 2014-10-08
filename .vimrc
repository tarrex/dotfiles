"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Hawkeye's vimrc
"2013-09-26
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"语法支持
syn on

"缩进
set autoindent
set smartindent

"在INSERT模式下用退格键删除
set bs=2

"代码匹配
set showmatch

"总是显示状态行
set laststatus=2

"以下三个配置配合使用，设置Tab和缩进空格数
set expandtab
set shiftwidth=4
set tabstop=8

"为光标所在行加下划线
"set cursorline

"显示行号
set number

"文件在vim之外修改过，自动重新读入
set autoread

"检索时忽略大小写
set ignorecase

"使用utf-8或gbk打开文件
set fileencodings=utf-8,gbk

"检索时高亮显示匹配
set hls

"帮助系统语言设置
set helplang=en

"代码折叠
"set foldmethod=syntax
"设置折叠模式 
"set foldcolumn=2
"光标遇到折叠，折叠就打开 
"set foldopen=all 
"移开折叠时自动关闭折叠 
"set foldclose=all

"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ','
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>

"pathogen插件函数调用                       +2013-2-1 18:55:03
call pathogen#infect()

"powerline插件设置                +2013-2-1 19:16:26
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'fancy'

"taglist插件设置                            +2013-2-1 19:39:14
let Tlist_Show_One_File = 1			        "只显示当前文件的taglist，默认是显示多个
let Tlist_Exit_OnlyWindow = 1			    "如果taglist是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1			    "在右侧窗口中显示taglist
let Tlist_GainFocus_On_ToggleOpen = 1		"打开taglist时，光标保留在taglist窗口
let Tlist_Ctags_Cmd='/opt/local/bin/ctags'	"设置ctags命令的位置
nnoremap <leader>tl : Tlist<CR>             "设置关闭和打开taglist窗口的快捷键

"自动补全功能插件       +2013-2-1 20:14:31
let g:neocomplcache_enable_at_startup = 1

"自动补全括号                               +2013-2-7 02:04:02
:inoremap <S-ENTER> <c-r>=SkipPair()<CR>
:inoremap <S-SPACE> <ESC>la
:inoremap <C-ENTER> <ESC>A;<CR>
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { <c-r>=ClsoeBrace()<CR>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap ;; <ESC>A;<CR>

function ClosePair(char)
   if getline('.')[col('.') - 1] == a:char
      return "\<Right>"
   else
      return a:char
   endif
endf
function Semicolon()
   "echo getline('.')[col('.')]
   if getline('.')[col('.')] == ')'
      return "<ESC>A;"
   elseif getline('.')[col('.')] == '}'
      return "\<ESC>A;"
   elseif getline('.')[col('.')] == ']'
      return "\<ESC>A;"
   else
      return ";"
   endif
endf
function SkipPair()
   if getline('.')[col('.') - 1] == ')'
      return "\<ESC>o"
   else
      normal j
      let curline = line('.')
      let nxtline = curline
      while curline == nxtline
         if getline('.')[col('.') - 1] == '}'
            normal j
            let nxtline = nxtline + 1
            let curline = line('.')
            continue
         else
            return "\<ESC>i"
         endif
         
      endwhile
      return "\<ESC>o"
   endif
endf
function ClsoeBrace()
   if getline('.')[col('.') - 2] == '='
      return "{}\<ESC>i"
   elseif getline('.')[col('.') - 3] == '='
      return "{}\<ESC>i"
   elseif getline('.')[col('.') - 1] == '{'
      return "{}\<ESC>i"
   elseif getline('.')[col('.') - 2] == '{'
      return "{}\<ESC>i"
   elseif getline('.')[col('.') - 2] == ','
      return "{}\<ESC>i"
   elseif getline('.')[col('.') - 3] == ','
      return "{}\<ESC>i"
   else
      return "{\<ENTER>}\<ESC>O"
   endif
endf

" 图形界面
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr

    " 高亮光标所在的行
    set cursorline

	" Under Linux/Unix etc.
    	if has("unix") && !has('gui_macvim')
        	set guifont=Courier\ 10\ Pitch\ 11
    	endif
endif

" 插入模式按 F4 插入当前时间
imap <f4> <C-r>=GetDateStamp()<cr>

" Key Shortcut
nmap <C-t>   :tabnew<cr>
nmap <C-p>   :tabprevious<cr>
nmap <C-n>   :tabnext<cr>
nmap <C-k>   :tabclose<cr>
nmap <C-Tab> :tabnext<cr> 

" Color Scheme
if has('syntax')
    colorscheme elflord

    " 默认编辑器配色
    au BufNewFile,BufRead,BufEnter,WinEnter * colo elflord

    " 各不同类型的文件配色不同
    au BufNewFile,BufRead,BufEnter,WinEnter *.wiki colo void

    " 保证语法高亮
    syntax on
endif

"打开光标的行列位置显示功能 
set ruler