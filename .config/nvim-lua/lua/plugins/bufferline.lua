local ok, bufferline = pcall(require, 'bufferline')
if not ok then return end

bufferline.setup({
  options = {
    mode = 'tabs',
    numbers = 'none',
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = false,
    show_duplicate_prefix = false,
    always_show_bufferline = false,
  },
})

vim.keymap.set('n', 'bp', '<cmd>BufferLinePick<cr>')
