local ok, null_ls = pcall(require, 'null-ls')
if not ok then return end

null_ls.setup({
  sources = {
    -- go
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.formatting.goimports,

    -- python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.yapf,

    -- eslint
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.eslint,

    -- prettier
    null_ls.builtins.formatting.prettier,

    -- c
    null_ls.builtins.formatting.clang_format,
  }
})
