local ok, hop = pcall(require, 'hop')
if not ok then return end

hop.setup({
  keys = 'asdfghjklqwertyuiopzxcvbnm',
})

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'x' }, 'Sw', '<cmd>HopWord<cr>', opts)
vim.keymap.set({ 'n', 'x' }, 'S/', '<cmd>HopPattern<cr>', opts)
vim.keymap.set({ 'n', 'x' }, 'Sl', '<cmd>HopLineStart<cr>', opts)
vim.keymap.set({ 'n', 'x' }, 'Sc', '<cmd>HopChar1<cr>', opts)
