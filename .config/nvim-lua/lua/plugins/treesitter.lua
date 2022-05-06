local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

treesitter.setup({
  ensure_installed = {
    'bash', 'beancount', 'c', 'comment', 'cpp', 'css', 'dockerfile', 'go',
    'help', 'html', 'javascript', 'json', 'lua', 'make', 'markdown',
    'python', 'rust', 'scheme', 'scss', 'typescript', 'vim', 'yaml'
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  -- Modules
  -- Consistent syntax highlighting
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},
  },
})
