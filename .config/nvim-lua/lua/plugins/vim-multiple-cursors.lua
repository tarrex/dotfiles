vim.g.multi_cursor_use_default_mapping = 0

vim.keymap.set('n', '<mc>', '<nop>')
vim.keymap.set('n', 'C', '<mc>', { noremap = false })

vim.g.multi_cursor_start_word_key      = '<mc>'
vim.g.multi_cursor_select_all_word_key = '<leader><mc>'
vim.g.multi_cursor_start_key           = 'g<mc>'
vim.g.multi_cursor_select_all_key      = 'g<leader><mc>'
vim.g.multi_cursor_next_key            = '<c-n>'
vim.g.multi_cursor_prev_key            = '<c-p>'
vim.g.multi_cursor_skip_key            = '<c-x>'
vim.g.multi_cursor_quit_key            = '<esc>'
