local M = {}

M.setup = function()
  -- Signs
  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Diagnostic
  local config = {
    virtual_text = false,
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = ''
    }
  }
  vim.diagnostic.config(config)

  -- Handlers
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
    width = 60,
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
    width = 60,
  })

  -- Log level
  vim.lsp.set_log_level(vim.log.levels.ERROR)
end

-- Keymaps
local lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

  local ok, telescope = pcall(require, 'telescope.builtin')
  if ok then
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
    vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
    vim.keymap.set('n', '<space>e', telescope.diagnostics, opts)
  else
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  end

  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)

  -- vim.keymap.set('n', 'ff', vim.lsp.buf.formatting, opts)
end

-- Formatting
local formatting = function()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
  })
end
local lsp_formatting = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    -- vim.api.nvim_create_augroup('LspFormatting', { clear = false })
    -- vim.api.nvim_clear_autocmds({ group = 'LspFormatting', buffer = bufnr })
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   group = 'LspFormatting',
    --   buffer = bufnr,
    --   callback = function()
    --     formatting(bufnr)
    --   end,
    -- })
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'ff', formatting, opts)
  end
end

-- Show line diagnostics automatically in hover window
local lsp_hover_diagnostics = function(bufnr)
  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

-- Highlight symbol under cursor
local lsp_document_highlight = function(client, bufnr)
  if client.server_capabilities.document_highlight then
    vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])
    vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
    vim.api.nvim_clear_autocmds({ group = 'LspDocumentHighlight', buffer = bufnr })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'LspDocumentHighlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'LspDocumentHighlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- LSP on_attach
M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_formatting(client, bufnr)
  lsp_hover_diagnostics(bufnr)
  lsp_document_highlight(client, bufnr)

  if vim.g.logging_level == 'debug' then
    local msg = string.format('Language server %s started!', client.name)
    vim.notify(msg, 'info', { title = 'Nvim-config' })
  end
end

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities

return M
