local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then return end

local utils = require('utils')

local api = vim.api
local lsp = vim.lsp

local custom_attach = function(client, bufnr)
  -- Mappings.
  local opts = { silent = true, buffer = bufnr }
  -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', '<space>q', function() vim.diagnostic.setqflist({ open = true }) end, opts)

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, opts)

  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        source = 'always', -- show source in diagnostic popup window
        prefix = ' '
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  -- Set some key bindings conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.keymap.set('n', 'ff', vim.lsp.buf.formatting_sync, opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    vim.keymap.set('x', 'ff', vim.lsp.buf.range_formatting, opts)
  end

  -- The blow command will highlight the current variable and its usages in the buffer.
  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end

  if vim.g.logging_level == 'debug' then
    local msg = string.format('Language server %s started!', client.name)
    vim.notify(msg, 'info', { title = 'Nvim-config' })
  end
end

local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true


-- Change diagnostic signs.
vim.fn.sign_define('DiagnosticSignError', { text = '✗', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn',  { text = '!', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo',  { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint',  { text = '', texthl = 'DiagnosticSignHint' })

-- global config for diagnostic
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
})

-- lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
--   underline = false,
--   virtual_text = false,
--   signs = true,
--   update_in_insert = false,
-- })

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
lsp.handlers['textDocument/hover'] = lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

-- language server configuration
if utils.executable('bash-language-server') then
  lspconfig.bashls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('beancount-langserver') then
  lspconfig.beancount.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    init_options = {
      journalFile = '',
      pythonPath = 'python3',
    }
  })
end

if utils.executable('clangd') then
  lspconfig.clangd.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    filetypes = { 'c', 'cpp', 'cc' },
    -- flags = {
    --   debounce_text_changes = 500,
    -- },
  })
end

if utils.executable('vscode-css-language-server') then
  lspconfig.cssls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('vscode-eslint-language-server') then
  lspconfig.eslint.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('gopls') then
  lspconfig.gopls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('vscode-html-languageserver') then
  lspconfig.html.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('vscode-json-languageserver') then
  lspconfig.jsonls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('pyright') then
  lspconfig.pyright.setup {
    on_attach = custom_attach,
    capabilities = capabilities
  }
end

if utils.executable('rust-analyzer') then
  lspconfig.rust_analyzer.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('sql-language-server') then
  lspconfig.sql.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('lua-language-server') then
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  lspconfig.sumneko_lua.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

if utils.executable('typescript-language-server') then
  lspconfig.typescript.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
  })
end

if utils.executable('vim-language-server') then
  lspconfig.vimls.setup({
    on_attach = custom_attach,
    flags = {
      debounce_text_changes = 500,
    },
    capabilities = capabilities,
  })
end

if utils.executable('yaml-language-server') then
  lspconfig.yamlls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = {
          -- ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json'] = '/*.k8s.yaml',
          ['https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json'] = '/docker-compose*.y?(a)ml',
          ['https://json.schemastore.org/github-action.json'] = '/action.y?(a)ml',
          ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*'
        },
      }
    }
  })
end
