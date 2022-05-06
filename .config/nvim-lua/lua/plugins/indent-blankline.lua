local ok, indent = pcall(require, 'indent_blankline')
if not ok then return end

indent.setup({
  char = '▏',
  show_end_of_line = false,
  disable_with_nolist = false,
  buftype_exclude = { 'terminal' },
  filetype_exclude = { 'help', 'markdown', 'snippets', 'text', 'git', 'gitconfig', 'gitcommit', 'alpha' },

  show_current_context = true,
  show_current_context_start = true,
})
