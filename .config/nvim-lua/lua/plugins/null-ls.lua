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
    -- formatting.autopep8,
    -- formatting.yapf,
    formatting.isort,
    formatting.black,

    -- eslint
    diagnostics.eslint_d,
    formatting.eslint_d,
    action.eslint_d,

    -- c
    formatting.clang_format.with({
      extra_args = { '--style={BasedOnStyle: LLVM, IndentWidth: 4}' }
    }),

    -- lua
    formatting.stylua.with({
      extra_args = {
        '--column-width', '120',
        '--line-endings', 'Unix',
        '--indent-type', 'Spaces',
        '--indent-width', '2',
        '--quote-style', 'AutoPreferSingle',
        '--call-parentheses', 'Always',
        '--collapse-simple-statement', 'ConditionalOnly',
      }
    })
  },
})
