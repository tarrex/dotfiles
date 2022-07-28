local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

treesitter.setup({
  ensure_installed = {
    'c', 'cpp', 'go', 'python', 'rust', 'lua',
    'html', 'css', 'scss', 'javascript', 'typescript',
    'json', 'yaml', 'toml'
  },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
  },
})
