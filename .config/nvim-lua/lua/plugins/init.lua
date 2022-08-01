-- Packer init
local install_path = string.format('%s/site/pack/packer/start/packer.nvim', vim.fn.stdpath('data'))
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.cmd('packadd packer.nvim')
end

-- Autocommand that reloads neovim whenever you save the plugins module file
vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'packer_user_config',
  pattern = '~/.config/nvim/lua/plugins/*.lua',
  command = 'source <afile> | PackerCompile'
})

-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, 'packer')
if not ok then return end

packer.init({
  auto_clean = true,
  compile_on_sync = true,
  git = {
    default_url_format = 'https://github.com/%s'
  },
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end
  },
  profile = {
    enable = false,
    threshold = 1
  }
})

packer.startup(function(use)
  -- packer
  use { 'wbthomason/packer.nvim' }

  -- dependencies
  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }

  -- colorscheme
  use { 'lifepillar/vim-gruvbox8' }
  -- use { 'haishanh/night-owl.vim' }
  -- use { 'mofiqul/vscode.nvim' }
  -- use { 'tomasiser/vim-code-dark' }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    after = 'nvim-web-devicons',
    config = function()
      require('plugins.lualine')
    end
  }
  use {
    'akinsho/bufferline.nvim',
    after = 'nvim-web-devicons',
    config = function()
      require('plugins.bufferline')
    end,
  }

  use {
    'goolord/alpha-nvim',
    after = 'nvim-web-devicons',
    config = function()
      require('plugins.alpha')
    end
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v1',
    config = function()
      require('plugins.hop')
    end
  }

  use {
    'terryma/vim-multiple-cursors',
    config = function()
      require('plugins.vim-multiple-cursors')
    end
  }

  use {
    'junegunn/vim-easy-align',
    cmd = 'EasyAlign'
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('plugins.colorizer')
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent-blankline')
    end
  }

  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('plugins.neoscroll')
    end,
  }

  use {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    config = function()
      require('plugins.zen-mode')
    end,
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-project.nvim',
    },
    config = function()
      require('plugins.telescope')
    end
  }
  use {
    'mbbill/undotree',
     config = function()
       require('plugins.undotree')
     end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end
  }

  use 'machakann/vim-sandwich'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use {
    'editorconfig/editorconfig-vim',
    config = function()
      require('plugins.editorconfig')
    end
  }

  use {
    'liuchengxu/vista.vim',
    config = function()
      require('plugins.vista')
    end,
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('plugins.treesitter')
    end
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/lsp-colors.nvim',
      'ray-x/lsp_signature.nvim',
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
      'j-hui/fidget.nvim'
    },
    config = function()
      require('plugins.lsp')
    end
  }

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      {
        'l3mon4d3/luasnip',
        requires = {
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets'
        },
        config = function()
          require('plugins.luasnip')
        end
      },
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('plugins.cmp')
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    after = 'plenary.nvim',
    config = function()
      require('plugins.null-ls')
    end
  }

  -- filetype
  use { 'kovisoft/paredit', ft = 'scheme' }
  use {
    'tpope/vim-markdown',
    ft = 'markdown',
    config = function()
      require('plugins.vim-markdown')
    end
  }
  use {
    'dhruvasagar/vim-table-mode',
    ft = 'markdown',
    config = function()
      require('plugins.vim-table-mode')
    end,
    cmd = 'TableModeToggle'
  }
  use { 'tarrex/nginx.vim', ft = 'nginx' }
  use { 'mtdl9/vim-log-highlighting', ft = 'log' }

  -- use 'wakatime/vim-wakatime'
  -- use 'tweekmonster/startuptime.vim'
  -- use 'dstein64/vim-startuptime'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
