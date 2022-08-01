local ok, mason = pcall(require, 'mason')
if not ok then return end

mason.setup({
  ui = {
    border = 'rounded',
  },
  install_root_dir = vim.fn.stdpath('data') .. '/mason',
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
  github = {
    download_url_template = 'https://github.com/%s/releases/download/%s/%s'
  }
})

local servers = {
  'gopls', 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua',
  'html', 'cssls', 'tsserver', 'eslint', 'yamlls', 'jsonls',
  'bashls', 'vimls'
}

local mason_config = require('mason-lspconfig')
mason_config.setup({
  ensure_installed = servers,
  automatic_installation = false,
})

local lsp = require('lspconfig')
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

local signature_ok, signature = pcall(require, 'lsp_signature')
if signature_ok then
  signature.setup({
    hint_enable = false,
    -- hint_prefix = '🐼 ',
    -- hint_scheme = 'String',
  })
end

local colors_ok, colors = pcall(require, 'lsp-colors')
if colors_ok then
  colors.setup({
    Error = '#db4b4b',
    Warning = '#e0af68',
    Information = '#0db9d7',
    Hint = '#10B981'
  })
end

local lines_ok, lines = pcall(require, 'lsp_lines')
if lines_ok then
  lines.setup({
    vim.diagnostic.config({ virtual_lines = false })
  })
  vim.keymap.set('', '<Leader>l', lines.toggle)
end

local fidget_ok, fidget = pcall(require, 'fidget')
if fidget_ok then
  fidget.setup({
    text = {
      spinner = 'clock',
      done = '✅ ',
    },
    align = {
      bottom = true,
      right = true,
    },
  })
end
