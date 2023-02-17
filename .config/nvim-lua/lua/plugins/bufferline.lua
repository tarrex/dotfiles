local ok, bufferline = pcall(require, 'bufferline')
if not ok then return end

bufferline.setup({
  options = {
    mode = 'tabs',
    numbers = 'none',
    close_command = 'bdelete! %d',
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = 'x',
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    diagnostics = false,
    custom_filter = function(bufnr)
      local exclude_ft = { 'qf', 'fugitive', 'git' }
      local current_ft = vim.bo[bufnr].filetype
      if vim.tbl_contains(exclude_ft, current_ft) then
        return false
      end
      return true
    end,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = false,
    always_show_bufferline = false,
    sort_by = 'id',
  },
})

vim.keymap.set('n', 'bp', '<cmd>BufferLinePick<cr>')
