local ok, _ = pcall(require, 'lspconfig')
if not ok then return end

require('plugins.lsp.configs')
require('plugins.lsp.handlers').setup()
