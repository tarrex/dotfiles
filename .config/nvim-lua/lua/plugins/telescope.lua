local ok, telescope = pcall(require, 'telescope')
if not ok then return end

local actions = require('telescope.actions')
local utils   = require('utils')

telescope.setup({
  defaults = {
    layout_config = { prompt_position = 'top' },
    layout_strategy = 'horizontal',
    sorting_strategy = 'ascending',
    use_less = false,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-h>'] = { '<Left>', type = 'command' },
        ['<C-l>'] = { '<Right>', type = 'command' },
        ['<C-b>'] = actions.preview_scrolling_up,
        ['<C-f>'] = actions.preview_scrolling_down
      }
    },
    file_ignore_patterns = { 'node_modules', '.git' },
    path_display = { 'smart' }
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      find_command = { 'rg', '--ignore', '--hidden', '--files' },
      prompt_prefix = '🔍> '
    },
    live_grep = {
      theme = 'dropdown',
      only_sort_text = true
    },
    buffers = {
      theme = 'dropdown',
      only_sort_text = true
    },
    oldfiles = {
      theme = 'dropdown',
      only_sort_text = true
    },
    quickfix = {
      theme = 'dropdown',
      only_sort_text = true
    },
    loclist = {
      theme = 'dropdown',
      only_sort_text = true
    },
    git_commits = {
      theme = 'dropdown',
      only_sort_text = true
    },
    git_bcommits = {
      theme = 'dropdown',
      only_sort_text = true
    },
  }
})

utils.nmap('<space>fb', '<cmd>Telescope buffers<cr>')
utils.nmap('<space>fc', '<cmd>Telescope git_commits<cr>')
utils.nmap('<space>ff', '<cmd>Telescope find_files<cr>')
utils.nmap('<space>fg', '<cmd>Telescope live_grep<cr>')
utils.nmap('<space>fh', '<cmd>Telescope help_tags<cr>')
utils.nmap('<space>fm', '<cmd>Telescope keymaps<cr>')
utils.nmap('<space>fr', '<cmd>Telescope resume<cr>')
utils.nmap('<space>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
