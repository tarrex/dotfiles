local ok, hop = pcall(require, 'hop')
if not ok then return end

hop.setup({
  key = 'asdfghjklqwertyuiopzxcvbnm',
  case_insensitive = true,
  quit_key = '<ESC>',
})

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'x' }, 'Sw', '<cmd>HopWord<cr>', opts)
vim.keymap.set({ 'n', 'x' }, 'S/', '<cmd>HopPattern<cr>', opts)
vim.keymap.set({ 'n', 'x' }, 'Sl', '<cmd>HopLineStart<cr>', opts)
