local ok, alpha = pcall(require, 'alpha')
if not ok then return end

local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.val = {
  '                                                     ',
  '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                     ',
}

dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>', {}),
  dashboard.button('f', '  Find file', ':Telescope find_files <CR>', {}),
  -- dashboard.button('p', '  Find project', ':Telescope projects <CR>', {}),
  dashboard.button('r', '  Recently files', ':Telescope oldfiles <CR>', {}),
  dashboard.button('t', '  Find text', ':Telescope live_grep <CR>', {}),
  dashboard.button('c', '  Configuration', ':e ~/.config/nvim <CR>', {}),
  dashboard.button('q', '  Quit Neovim', ':qa<CR>', {}),
}

local footer = function ()
  return 'Enjoy vim, enjoy coding.'
end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = 'Include'
dashboard.section.buttons.opts.hl = 'Keyword'
dashboard.section.footer.opts.hl = 'Type'

dashboard.config.opts.noautocmd = true

alpha.setup(dashboard.config)
