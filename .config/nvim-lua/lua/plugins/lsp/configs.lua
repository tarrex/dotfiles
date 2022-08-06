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
  'bashls', 'vimls', 'jdtls'
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

-- lspsaga.nvim
local saga_ok, saga = pcall(require, 'lspsaga')
if saga_ok then
  saga.init_lsp_saga {
    border_style = 'rounded',
    saga_winblend = 30,
    code_action_lightbulb = {
      enable = false,
    },
    finder_icons = {
      def = '  ',
      ref = '  ',
      link = '  ',
    },
    finder_request_timeout = 1500,
  }

  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
  vim.keymap.set('n', 'gt', '<cmd>LSoutlineToggle<CR>', opts)
end

-- lsp-colors.nvim
local colors_ok, colors = pcall(require, 'lsp-colors')
if colors_ok then
  colors.setup({
    Error = '#db4b4b',
    Warning = '#e0af68',
    Information = '#0db9d7',
    Hint = '#10B981'
  })
end

-- lsp_signature.nvim
local signature_ok, signature = pcall(require, 'lsp_signature')
if signature_ok then
  signature.setup({
    hint_enable = false,
  })
end

-- fidget.nvim
local fidget_ok, fidget = pcall(require, 'fidget')
if fidget_ok then
  fidget.setup({
    text = {
      spinner = 'clock',
      done = '✅ ',
    },
  })
end

-- lsp_lines.nvim
local lines_ok, lines = pcall(require, 'lsp_lines')
if lines_ok then
  lines.setup({
    vim.diagnostic.config({ virtual_lines = false })
  })
  vim.keymap.set('', '<Leader>l', lines.toggle)
end

