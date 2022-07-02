local utils = require('utils')

vim.g.vista_sidebar_position     = 'vertical botright'
vim.g.vista_sidebar_width        = 30
vim.g.vista_echo_cursor          = 1
vim.g.vista_cursor_delay         = 400
vim.g.vista_echo_cursor_strategy = 'floating_win'
vim.g.vista_close_on_jump        = 0
vim.g.vista_stay_on_open         = 1
vim.g.vista_blink                = { 2, 100 }
vim.g.vista_default_executive    = 'ctags'
vim.g.vista_fzf_preview          = { 'right:50%' }
vim.g.vista_disable_statusline   = 1
-- vim.g.['vista#renderer#enable_icon'] = 0

utils.nmap('<localleader>t', ':Vista<cr>')
