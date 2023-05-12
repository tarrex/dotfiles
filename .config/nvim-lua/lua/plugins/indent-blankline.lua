local ok, indent = pcall(require, 'indent_blankline')
if not ok then return end

indent.setup({
  char = '▏',
  show_end_of_line = false,
  disable_with_nolist = false,
  buftype_exclude = {
    'terminal',
    'nofile',
    'quickfix',
    'prompt',
  },
  filetype_exclude = {
    'alpha',
    'checkhealth',
    'git',
    'gitcommit',
    'help',
    'json',
    'lazy',
    'log',
    'lspinfo',
    'man',
    'markdown',
    'snippets',
    'startuptime',
    'TelescopePrompt',
    'text',
    'undotree',
    '',
  },

  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = true,
  context_char = '▏',
})
