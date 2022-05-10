local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

treesitter.setup({
  ensure_installed = {
    'bash', 'beancount', 'c', 'comment', 'cpp', 'css', 'dockerfile', 'go',
    'help', 'html', 'javascript', 'json', 'lua', 'make', 'markdown',
    'python', 'rust', 'scheme', 'scss', 'toml', 'typescript', 'vim', 'yaml'
  },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
  },
})
