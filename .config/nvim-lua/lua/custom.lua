local utils = require('utils')

local g   = vim.g
local cmd = vim.cmd

----> Highlights
cmd([[
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
]])

----> Color
cmd([[silent! colorscheme gruvbox8_hard]])

----> Filetype detect and custom
cmd([[
augroup FileTypeDetectAndCustom
  autocmd!
  autocmd BufRead,BufNewFile nginx.*.conf       setf nginx
  autocmd BufRead,BufNewFile *.bean,*.beancount setf beancount
  autocmd FileType qf                           setl nonu nornu
  autocmd FileType gitcommit                    setl spell
  autocmd FileType html,css,less,sass,scss      setl sw=2 ts=2 sts=2
  autocmd FileType json,markdown,yaml           setl sw=2 ts=2 sts=2
  autocmd FileType javascript,javascriptreact   setl sw=2 ts=2 sts=2
  autocmd FileType typescript,typescriptreact   setl sw=2 ts=2 sts=2
  autocmd FileType lua                          setl sw=2 ts=2 sts=2
augroup END
]])

----> Templates
cmd([[
let s:templatesdir = expand('~/.config/nvim/templates')
if isdirectory(s:templatesdir)
  augroup Templates
    autocmd!
    autocmd BufNewFile .editorconfig sil! exe '0r '.s:templatesdir.'/editorconfig'
  augroup END
endif
]])

----> Tricks
cmd([[
augroup VimTricks
  autocmd!
  " trim trailing whitespace on write
  autocmd BufWritePre * if !&bin | exe 'normal mz' | exe ':keepp %s/\v\s+$//ge' | exe 'normal `z' | endif
  " remember cursor position
  autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
  " close the quickfix or locationlist window when exiting
  autocmd QuitPre     * if empty(&buftype) | cclose | lclose | endif
  " auto source $MYVIMRC
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  " don't list terminal buffer at buffer list
  autocmd TermOpen term://* setl nobl nonu nornu | startinsert
  " automatically equalize windows when vim is resized
  autocmd VimResized * wincmd =
augroup END
]])

----> Commands
cmd([[
command! -nargs=* -complete=mapping AllMaps map <args> | map! <args> | lmap <args>
command! RemoveBlankLine sil g/^$/d | noh | normal! ``
command! RTP echo substitute(&runtimepath, ',', '\n', 'g')
command! SaveAsUTF8 setl fenc=utf-8 | w
command! Tab2Space sil %s/\t/    /g | noh | normal! ``
command! CurrentPath echo expand('%:p')
]])

----> Disable some built-in plugins
local disabled_built_ins = {
  '2html_plugin',
  'gzip',
  'matchit',
  -- 'netrw',
  -- 'netrwFileHandlers',
  -- 'netrwPlugin',
  -- 'netrwSettings',
  'remote_plugins',
  'spellfile_plugin',
  'tar',
  'tarPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  g[string.format('loaded_%s', plugin)] = 1
end

----> Providers config
g.loaded_pythonx_provider = 0
g.loaded_python_provider  = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider    = 0
g.loaded_perl_provider    = 0
g.loaded_node_provider    = 0

----> Zen mode
cmd([[
function! ZenModeToggle() abort
  if exists('s:zen_mode')
    set smd ru sc nu ls=2
    unlet s:zen_mode
  else
    set nosmd noru nosc nonu ls=0
    let s:zen_mode = 1
  endif
endfunction
nnoremap <silent> <space>z :call ZenModeToggle()<cr>
]])

----> View changes after the last save
cmd([[
function! DiffWithSaved() abort
  let l:save_pos = getpos('.')
  let l:filetype = &ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  execute 'setlocal bt=nofile bh=wipe nobl noswf ro ft=' . filetype
  execute 'normal! ]c'
  call setpos('.', l:save_pos)
endfunction
nnoremap <silent> <space>d :call DiffWithSaved()<cr>
]])

----> Toggle Quickfix / LocationList window
cmd([[
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
]])

----> Open current buffer directory in finder or explorer
if utils.ostype.mac then
  utils.nmap('<leader>e', [[:silent execute '![ -f "%:p" ] && open -R "%:p" || open "%:p:h"' | redraw!<cr>]])
  utils.nmap('<leader>E', [[:silent execute '!open .' | redraw!<cr>]])
elseif utils.ostype.linux then
  utils.nmap('<leader>e', [[:silent execute '!xdg-open "%:p:h"' | redraw!<cr>]])
  utils.nmap('<leader>E', [[:silent execute '!xdg-open .' | redraw!<cr>]])
end

----> Echo start time when starting
-- cmd([[
-- let s:startuptime = reltime()
-- augroup StartupTime
--   autocmd!
--   autocmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
--                       \ | echomsg 'StartupTime:' . reltimestr(s:startuptime) . 's'
-- augroup END
-- ]])
