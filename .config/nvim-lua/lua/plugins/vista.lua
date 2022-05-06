local utils = require('utils')
local g     = vim.g

g.vista_sidebar_position     = 'vertical botright'
g.vista_sidebar_width        = 30
g.vista_echo_cursor          = 1
g.vista_cursor_delay         = 400
g.vista_echo_cursor_strategy = 'floating_win'
g.vista_close_on_jump        = 0
g.vista_stay_on_open         = 1
g.vista_blink                = { 2, 100 }
g.vista_default_executive    = 'ctags'
g.vista_fzf_preview          = { 'right:50%' }
g.vista_disable_statusline   = 1
-- g.['vista#renderer#enable_icon'] = 0

utils.nmap('<localleader>t', ':Vista<cr>')
