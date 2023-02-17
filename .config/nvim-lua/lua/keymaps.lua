vim.g.mapleader      = ','
vim.g.maplocalleader = '\\'

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable Ex mode and command history key bindings
map('n', 'Q',  '<nop>', opts)
map('n', 'q:', '<nop>', opts)

-- Toggle number,paste,cuc,list,wrap,spell and so on.
map('n', '<localleader>n', ':setl number! nu?<cr>', opts)
map('n', '<localleader>r', ':setl relativenumber! rnu?<cr>', opts)
map('n', '<localleader>p', ':setl paste!<cr>', opts)
map('n', '<localleader>c', ':setl cursorcolumn! cuc?<cr>', opts)
map('n', '<localleader>l', ':setl list! list?<cr>', opts)
map('n', '<localleader>w', ':setl wrap! wrap?<cr>', opts)
map('n', '<localleader>s', ':setl spell! spelllang=en_us<cr>', opts)
map('n', '<localleader>f', ':setl foldenable! nofen?<cr>', opts)
map('n', '<localleader>b', [[:let &bg=(&bg=='dark'?'light':'dark')<cr>]], opts)

-- Buffer switching
map('n', '[b',    ':bprevious<cr>', opts)
map('n', ']b',    ':bnext<cr>', opts)
map('n', '[B',    ':bfirst<cr>', opts)
map('n', ']B',    ':blast<cr>', opts)
map('n', '<c-q>', ':bdelete<cr>', opts)

-- Tab switching
map('n', '[t', ':tabprevious<cr>', opts)
map('n', ']t', ':tabnext<cr>', opts)
map('n', '[T', ':tabfirst<cr>', opts)
map('n', ']T', ':tablast<cr>', opts)
map('n', '<c-t>', ':tabnew<cr>', opts)
map('i', '<c-t>', '<esc>:tabnew<cr>', opts)
map('n', 'tt', ':<c-u>call MoveToTab()<cr>', opts)
vim.cmd([[
function! MoveToTab() abort
  tab split | tabprevious
  if winnr('$') > 1 | close | elseif bufnr('$') > 1 | buffer # | endif
  tabnext
endfunction
]])

-- Quickfox switching
map('n', '[q', ':cprevious<cr>', opts)
map('n', ']q', ':cnext<cr>', opts)
map('n', '[Q', ':cfirst<cr>', opts)
map('n', ']Q', ':clast<cr>', opts)

-- LocationList switching
map('n', '[l', ':lprevious<cr>', opts)
map('n', ']l', ':lnext<cr>', opts)
map('n', '[L', ':lfirst<cr>', opts)
map('n', ']L', ':llast<cr>', opts)

-- Preview window switching
map('n', '[<c-t>', ':ptprevious<cr>', opts)
map('n', ']<c-t>', ':ptnext<cr>', opts)

-- Window switching in normal mode
map('n', '<c-h>', '<c-w>h', opts)
map('n', '<c-j>', '<c-w>j', opts)
map('n', '<c-k>', '<c-w>k', opts)
map('n', '<c-l>', '<c-w>l', opts)

-- Window switching in terminal mode
map('t', '<c-h>', '<c-_>h', opts)
map('t', '<c-j>', '<c-_>j', opts)
map('t', '<c-k>', '<c-_>k', opts)
map('t', '<c-l>', '<c-_>l', opts)
map('t', '<c-q>', '<c-_>:q!<cr>', opts)

-- Search will center on the line it's found in, conflict with shortmess-=S option
-- map('n', 'n', 'nzzzv', opts)
-- map('n', 'N', 'Nzzzv', opts)

-- Move lines left or right
map('n', '<', '<<', opts)
map('n', '>', '>>', opts)
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move lines up or down
-- map('n', '<up>',   ':m-2<cr>==', opts)
-- map('n', '<down>', ':m+1<cr>==', opts)
map('v', '<down>', [[:m '>+1<cr>gv=gv]], opts)
map('v', '<up>',   [[:m '<-2<cr>gv=gv]], opts)

-- Search in selected visual block
map('v', '/', [[:<c-u>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<cr>]], opts)

-- Fast save
map('n', '<c-s>', ':update<cr>', opts)
map('i', '<c-s>', '<esc>:update<cr>', opts)

-- Replace a word
map('n', '<space>y', 'yiw', opts)
map('n', '<space>p', 'viw"0p', opts)

-- Do not yank when x
map('n', 'x', '"_x', opts)

-- Move vertically by visual line
-- map('n', 'j', [[v:count ? 'j' : 'gj']], { silent = true, expr = true })
-- map('n', 'k', [[v:count ? 'k' : 'gk']], { silent = true, expr = true })
-- map('v', 'j', [[v:count ? 'j' : 'gj']], { silent = true, expr = true })
-- map('v', 'k', [[v:count ? 'k' : 'gk']], { silent = true, expr = true })

-- Switch to working directory of the open file
map('n', '<leader>cd', ':<c-u>lcd %:p:h<cr>:pwd<cr>', opts)

-- Turn off search highlight
map('n', '<space>n', ':nohlsearch<cr>', opts)

-- Open terminal on the right
map('n', '<space>t', ':terminal<cr>', opts)

-- Hex read
map('n', '<space>hr', ':%!xxd<cr> :set filetype=xxd<cr>', opts)
-- Hex write
map('n', '<space>hw', ':%!xxd -r<cr> :set binary<cr> :set filetype=<cr>', opts)

-- Map w!! to write file with sudo
map('c', 'w!!', [[execute 'silent! write !sudo tee % >/dev/null' <bar> edit!]], opts)

-- Rotate tab size
map('n', '<space>v', [[:let &ts=(&ts*2 > 16 ? 2 : &ts*2)<cr>:echo "tabstop:" . &ts<cr>]], opts)

-- Toggle current cursor position to top / center / bottom
map('n', 'zz', [[(winline() == (winheight(0) + 1) / 2) ?  'zt' : (winline() <= 2)? 'zb' : 'zz']], { expr = true })

-- Reselect the text that has just been pasted
map('n', '<space>s', '`[V`]', opts)

-- Select all content
map('n', '<space>aa', 'ggVG', opts)

-- Resize window
map('n', '<space>-', ':resize -2<cr>', opts)
map('n', '<space>=', ':resize +2<cr>', opts)
map('n', '<space>[', ':vertical resize -2<cr>', opts)
map('n', '<space>]', ':vertical resize +2<cr>', opts)
map('n', '<space>/', ':wincmd =<cr>', opts)

-- Correct vim exit command
vim.cmd([[
  cnoreabbrev Wq      wq
  cnoreabbrev Wa      wa
  cnoreabbrev wQ      wq
  cnoreabbrev WQ      wq
  cnoreabbrev W       w
  cnoreabbrev Q       q
  cnoreabbrev Qall    qall
]])

