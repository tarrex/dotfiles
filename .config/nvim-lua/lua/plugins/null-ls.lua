local ok, null_ls = pcall(require, 'null-ls')
if not ok then return end

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local action = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- go
    diagnostics.golangci_lint,
    formatting.goimports,

    -- python
    formatting.autopep8,
    formatting.yapf,

    -- eslint
    diagnostics.eslint,
    formatting.eslint,
    action.eslint,

    -- c
    formatting.clang_format.with({
      extra_args = { '--style={BasedOnStyle: LLVM, IndentWidth: 4}' }
    }),
  },
})
