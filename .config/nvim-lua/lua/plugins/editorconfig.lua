local g   = vim.g
local cmd = vim.cmd

g.EditorConfig_disable_rules = { 'trim_trailing_whitespace' }
g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }

cmd([[
  augroup EditorConfig
    autocmd!
    autocmd FileType gitcommit let b:EditorConfig_disable = 1
  augroup END
]])
