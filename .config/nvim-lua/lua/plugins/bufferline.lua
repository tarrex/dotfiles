local ok, bufferline = pcall(require, 'bufferline')
if not ok then return end

local utils = require('utils')

bufferline.setup({
  options = {
    numbers = 'none',
    close_command = 'bdelete! %d',
    indicator_icon = '▎',
    buffer_close_icon = 'x',
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    diagnostics = false,
    custom_filter = function(bufnr)
      local exclude_ft = { 'qf', 'fugitive', 'git' }
      local cur_ft = vim.bo[bufnr].filetype
      local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

      if should_filter then
        return false
      end

      return true
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = false,
    always_show_bufferline = false,
    sort_by = 'id',
  },
})

utils.nmap('bp', '<cmd>BufferLinePick<cr>')
