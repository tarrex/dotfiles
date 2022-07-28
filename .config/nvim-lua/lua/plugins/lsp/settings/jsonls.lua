local default_schemas = {
  {
    description = 'TypeScript compiler configuration file',
    fileMatch = {
      'tsconfig.json',
      'tsconfig.*.json',
    },
    url = 'https://json.schemastore.org/tsconfig.json',
  },
  {
    description = 'Babel configuration',
    fileMatch = {
      '.babelrc.json',
      '.babelrc',
      'babel.config.json',
    },
    url = 'https://json.schemastore.org/babelrc.json',
  },
  {
    description = 'ESLint config',
    fileMatch = {
      '.eslintrc.json',
      '.eslintrc',
    },
    url = 'https://json.schemastore.org/eslintrc.json',
  },
  {
    description = 'Prettier config',
    fileMatch = {
      '.prettierrc',
      '.prettierrc.json',
      'prettier.config.json',
    },
    url = 'https://json.schemastore.org/prettierrc',
  },
  {
    description = 'Stylelint config',
    fileMatch = {
      '.stylelintrc',
      '.stylelintrc.json',
      'stylelint.config.json',
    },
    url = 'https://json.schemastore.org/stylelintrc',
  },
  {
    description = 'LLVM compilation database',
    fileMatch = {
      'compile_commands.json',
    },
    url = 'https://json.schemastore.org/compile-commands.json',
  },
  {
    description = 'golangci-lint configuration file',
    fileMatch = {
      '.golangci.toml',
      '.golangci.json',
    },
    url = 'https://json.schemastore.org/golangci-lint.json',
  },
  {
    description = 'Packer template JSON configuration',
    fileMatch = {
      'packer.json',
    },
    url = 'https://json.schemastore.org/packer.json',
  },
  {
    description = 'NPM configuration file',
    fileMatch = {
      'package.json',
    },
    url = 'https://json.schemastore.org/package.json',
  },
}

local opts = {
  settings = {
    json = {
      schemas = default_schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 })
        end
      }
    }
  }
}

return opts
