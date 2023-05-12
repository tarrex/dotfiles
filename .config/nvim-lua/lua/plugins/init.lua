local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- colorscheme
  'lifepillar/vim-gruvbox8',

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugins.lualine')
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'BufRead' },
    config = function()
      require('plugins.bufferline')
    end,
  },

  {
    'phaazon/hop.nvim',
    config = function()
      require('plugins.hop')
    end,
  },

  {
    'terryma/vim-multiple-cursors',
    config = function()
      require('plugins.vim-multiple-cursors')
    end,
  },

  {
    'junegunn/vim-easy-align',
    cmd = 'EasyAlign',
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('plugins.colorizer')
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent-blankline')
    end,
  },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    config = function()
      require('plugins.zen-mode')
    end,
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-github.nvim',
    },
    config = function()
      require('plugins.telescope')
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      require('plugins.undotree')
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end,
  },

  'machakann/vim-sandwich',
  -- 'tpope/vim-surround',   -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  'tpope/vim-repeat',     -- enable repeating supported plugin maps with "."
  'tpope/vim-commentary', -- comment stuff out
  'tpope/vim-sleuth',     -- Heuristically set buffer options
  'tpope/vim-fugitive',   -- A Git wrapper so awesome, it should be illegal
  'tpope/vim-rhubarb',    -- GitHub extension for fugitive.vim

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
  },

  {
    'liuchengxu/vista.vim',
    config = function()
      require('plugins.vista')
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
    config = function()
      require('plugins.treesitter')
    end,
  },

  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/lsp-colors.nvim',
      'ray-x/lsp_signature.nvim',
      'j-hui/fidget.nvim',
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    },
    config = function()
      require('plugins.lsp')
    end,
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      {
        'l3mon4d3/luasnip',
        dependencies = {
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets',
        },
        config = function()
          require('plugins.luasnip')
        end,
      },
    },
    config = function()
      require('plugins.cmp')
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.null-ls')
    end,
  },

  -- filetype
  {
    'tpope/vim-markdown',
    ft = 'markdown',
    config = function()
      require('plugins.vim-markdown')
    end,
  },
  {
    'dhruvasagar/vim-table-mode',
    ft = 'markdown',
    config = function()
      require('plugins.vim-table-mode')
    end,
    cmd = 'TableModeToggle',
  },
  {
    'acksld/nvim-femaco.lua',
    ft = 'markdown',
    config = function()
      require('plugins.femaco')
    end,
  },
  { 'tarrex/nginx.vim', ft = 'nginx' },
  { 'mtdl9/vim-log-highlighting', ft = 'log' },

  -- { 'wakatime/vim-wakatime', event = 'InsertEnter' },
  -- { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' },
  -- { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
}

local ok, lazy = pcall(require, 'lazy')
if not ok then return end
lazy.setup(plugins)
