local ok, hop = pcall(require, 'hop')
if not ok then return end

local utils = require('utils')

hop.setup({
  key = 'asdfjkl;ghqweruioptyzxcvbnm',
  case_insensitive = true,
  quit_key = '<ESC>',
})

local opts = { noremap = false, silent = false }

utils.nmap('<hop>', '<nop>')
utils.nmap('S', '<hop>', opts)

utils.nmap('<hop>w', '<cmd>HopWord<cr>', opts)
utils.xmap('<hop>w', '<cmd>HopWord<cr>', opts)
utils.nmap('<hop>/', '<cmd>HopPattern<cr>', opts)
utils.xmap('<hop>/', '<cmd>HopPattern<cr>', opts)
utils.nmap('<hop>l', '<cmd>HopLineStart<cr>', opts)
utils.xmap('<hop>l', '<cmd>HopLineStart<cr>', opts)
