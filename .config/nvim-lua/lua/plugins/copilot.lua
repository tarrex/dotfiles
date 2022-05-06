local utils = require('utils')

vim.g.copilot_no_tab_map = true

utils.imap('<c-j>', 'copilot#Accept("<cr>")', { silent = true, script = true, expr = true })
