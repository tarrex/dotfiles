local ok, _telescope = pcall(require, 'telescope')
if not ok then return end

local actions = require('telescope.actions')

_telescope.setup({
  defaults = {
    prompt_prefix = '🔍',
    selection_caret = '👉',
    sorting_strategy = 'ascending',
    use_less = false,
    mappings = {
      i = {
        ['<Esc>'] = actions.close,
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

  pickers = {},
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  }
})

_telescope.load_extension('file_browser')
_telescope.load_extension('gh')

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<space>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<space>fc', '<cmd>Telescope git_commits<cr>', opts)
map('n', '<space>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<space>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<space>fh', '<cmd>Telescope help_tags<cr>', opts)
map('n', '<space>fm', '<cmd>Telescope keymaps<cr>', opts)
map('n', '<space>fr', '<cmd>Telescope resume<cr>', opts)
map('n', '<space>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)
map('n', '<space>fd', '<cmd>Telescope file_browser<cr>', opts)
map('n', '<space>fo', '<cmd>Telescope oldfiles<cr>', opts)
