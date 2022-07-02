vim.g.EditorConfig_disable_rules = { 'trim_trailing_whitespace' }
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }

vim.api.nvim_create_augroup('EditorConfig', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'EditorConfig',
  pattern = 'gitcommit',
  command = 'let b:EditorConfig_disable = 1'
})
