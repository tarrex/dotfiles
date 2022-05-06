local utils = require('utils')

local g   = vim.g
local cmd = vim.cmd

local nmap = utils.nmap
local imap = utils.imap
local vmap = utils.vmap
local cmap = utils.cmap
local tmap = utils.tmap

g.mapleader      = ','
g.maplocalleader = '\\'

-- Disable Ex mode and command history key bindings
nmap('Q',  '<nop>')
nmap('q:', '<nop>')

-- Toggle number,paste,cuc,list,wrap,spell and so on.
nmap('<localleader>n', ':setl number! nu?<cr>')
nmap('<localleader>r', ':setl relativenumber! rnu?<cr>')
nmap('<localleader>p', ':setl paste!<cr>')
nmap('<localleader>c', ':setl cursorcolumn! cuc?<cr>')
nmap('<localleader>l', ':setl list! list?<cr>')
nmap('<localleader>w', ':setl wrap! wrap?<cr>')
nmap('<localleader>s', ':setl spell! spelllang=en_us<cr>')
nmap('<localleader>f', ':setl foldenable! nofen?<cr>')
nmap('<localleader>b', [[:let &bg=(&bg=='dark'?'light':'dark')<cr>]])

-- Buffer switching
nmap('[b',    ':bprevious<cr>')
nmap(']b',    ':bnext<cr>')
nmap('[B',    ':bfirst<cr>')
nmap(']B',    ':blast<cr>')
nmap('<c-q>', ':bdelete<cr>')

-- Tab switching
nmap('[t', ':tabprevious<cr>')
nmap(']t', ':tabnext<cr>')
nmap('[T', ':tabfirst<cr>')
nmap(']T', ':tablast<cr>')
nmap('<c-t>', ':tabnew<cr>')
imap('<c-t>', '<esc>:tabnew<cr>')
nmap('tt', ':<c-u>call MoveToTab()<cr>')
cmd([[
function! MoveToTab() abort
  tab split | tabprevious
  if winnr('$') > 1 | close | elseif bufnr('$') > 1 | buffer # | endif
  tabnext
endfunction
]])

-- Quickfox switching
nmap('[q', ':cprevious<cr>')
nmap(']q', ':cnext<cr>')
nmap('[Q', ':cfirst<cr>')
nmap(']Q', ':clast<cr>')

-- LocationList switching
nmap('[l', ':lprevious<cr>')
nmap(']l', ':lnext<cr>')
nmap('[L', ':lfirst<cr>')
nmap(']L', ':llast<cr>')

-- Preview window switching
nmap('[<c-t>', ':ptprevious<cr>')
nmap(']<c-t>', ':ptnext<cr>')

-- Window switching in normal mode
nmap('<c-h>', '<c-w>h')
nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('<c-l>', '<c-w>l')

-- Window switching in terminal mode
tmap('<c-h>', '<c-_>h')
tmap('<c-j>', '<c-_>j')
tmap('<c-k>', '<c-_>k')
tmap('<c-l>', '<c-_>l')
tmap('<c-q>', '<c-_>:q!<cr>')

-- Search will center on the line it's found in, conflict with shortmess-=S option
-- nmap('n', 'nzzzv')
-- nmap('N', 'Nzzzv')

-- Move lines left or right
nmap('<', '<<')
nmap('>', '>>')
vmap('<', '<gv')
vmap('>', '>gv')

-- Move lines up or down
-- nmap('<up>',   ':m-2<cr>==')
-- nmap('<down>', ':m+1<cr>==')
vmap('<down>', [[:m '>+1<cr>gv=gv]])
vmap('<up>',   [[:m '<-2<cr>gv=gv]])

-- Search in selected visual block
vmap('/', [[:<c-u>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<cr>]])

-- Fast save
nmap('<c-s>', ':update<cr>')
imap('<c-s>', '<esc>:update<cr>')

-- Replace a word
nmap('<space>y', 'yiw')
nmap('<space>p', 'viw"0p')

-- Move vertically by visual line
-- nmap('j', [[v:count ? 'j' : 'gj']], { silent = true, expr = true })
-- nmap('k', [[v:count ? 'k' : 'gk']], { silent = true, expr = true })
-- vmap('j', [[v:count ? 'j' : 'gj']], { silent = true, expr = true })
-- vmap('k', [[v:count ? 'k' : 'gk']], { silent = true, expr = true })

-- Switch to working directory of the open file
nmap('<leader>cd', ':<c-u>lcd %:p:h<cr>:pwd<cr>')

-- Turn off search highlight
nmap('<space>n', ':nohlsearch<cr>')

-- Open terminal on the right
nmap('<space>t', ':terminal<cr>')

-- Hex read
nmap('<space>hr', ':%!xxd<cr> :set filetype=xxd<cr>')
-- Hex write
nmap('<space>hw', ':%!xxd -r<cr> :set binary<cr> :set filetype=<cr>')

-- Map w!! to write file with sudo
cmap('w!!', [[execute 'silent! write !sudo tee % >/dev/null' <bar> edit!]])

-- Rotate tab size
nmap('<space>v', [[:let &ts=(&ts*2 > 16 ? 2 : &ts*2)<cr>:echo "tabstop:" . &ts<cr>]])

-- Toggle current cursor position to top / center / bottom
nmap('zz', [[(winline() == (winheight(0) + 1) / 2) ?  'zt' : (winline() <= 2)? 'zb' : 'zz']], { expr = true })

-- Reselect the text that has just been pasted
nmap('<space>s', '`[V`]')

-- Select all content
nmap('<space>aa', 'ggVG')

-- Resize window
nmap('<space>-', ':resize -2<cr>')
nmap('<space>=', ':resize +2<cr>')
nmap('<space>[', ':vertical resize -2<cr>')
nmap('<space>]', ':vertical resize +2<cr>')
nmap('<space>/', ':wincmd =<cr>')

-- Correct vim exit command
cmd([[
  cnoreabbrev Wq      wq
  cnoreabbrev Wa      wa
  cnoreabbrev wQ      wq
  cnoreabbrev WQ      wq
  cnoreabbrev W       w
  cnoreabbrev Q       q
  cnoreabbrev Qall    qall
]])

