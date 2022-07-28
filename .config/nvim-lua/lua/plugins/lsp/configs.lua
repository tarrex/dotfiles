local ok, installer = pcall(require, 'nvim-lsp-installer')
if not ok then return end

local lsp = require('lspconfig')

local servers = {
  'gopls', 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua',
  'html', 'cssls', 'tsserver', 'eslint', 'yamlls', 'jsonls',
  'bashls', 'vimls'
}

installer.setup({
  ensure_installed = servers,
  automatic_installation = {
    exclude = {}
  },
  border = 'rounded',
  install_root_dir = vim.fn.stdpath('data') .. '/lsp_servers',
  github = {
    download_url_template = 'https://github.com/%s/releases/download/%s/%s'
  }
})

local handlers = require('plugins.lsp.handlers')

for _, server in pairs(servers) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities
  }

  local has_custom_opts, custom_opts = pcall(require, 'plugins.lsp.settings.' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', opts, custom_opts)
  end
  lsp[server].setup(opts)
end
