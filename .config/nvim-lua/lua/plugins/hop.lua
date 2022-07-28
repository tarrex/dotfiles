local ok, hop = pcall(require, 'hop')
if not ok then return end

hop.setup({
  key = 'asdfjkl;ghqweruioptyzxcvbnm',
  case_insensitive = true,
  quit_key = '<ESC>',
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<hop>', '<nop>')
map('n', 'S', '<hop>', opts)

map('n', '<hop>w', '<cmd>HopWord<cr>', opts)
map('x', '<hop>w', '<cmd>HopWord<cr>', opts)
map('n', '<hop>/', '<cmd>HopPattern<cr>', opts)
map('x', '<hop>/', '<cmd>HopPattern<cr>', opts)
map('n', '<hop>l', '<cmd>HopLineStart<cr>', opts)
map('x', '<hop>l', '<cmd>HopLineStart<cr>', opts)
