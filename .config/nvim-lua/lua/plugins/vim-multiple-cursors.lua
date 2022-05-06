local utils = require('utils')
local g     = vim.g

g.multi_cursor_use_default_mapping = 0

utils.nmap('<mc>', '<nop>')
utils.nmap('C', '<mc>', { noremap = false })

g.multi_cursor_start_word_key      = '<mc>'
g.multi_cursor_select_all_word_key = '<leader><mc>'
g.multi_cursor_start_key           = 'g<mc>'
g.multi_cursor_select_all_key      = 'g<leader><mc>'
g.multi_cursor_next_key            = '<c-n>'
g.multi_cursor_prev_key            = '<c-p>'
g.multi_cursor_skip_key            = '<c-x>'
g.multi_cursor_quit_key            = '<esc>'
