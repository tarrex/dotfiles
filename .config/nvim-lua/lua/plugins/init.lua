-- Packer init
local fn  = vim.fn
local cmd = vim.cmd

local install_path = string.format('%s/site/pack/packer/start/packer.nvim', fn.stdpath('data'))
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd('packadd packer.nvim')
end

-- Autocommand that reloads neovim whenever you save the plugins module file
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/plugins/*.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  },
  auto_clean = true,
  compole_on_sync = true
})

packer.startup(function(use)
  -- packer itself
  use { 'wbthomason/packer.nvim' }

  -- colorscheme
  use { 'lifepillar/vim-gruvbox8', opt = true }
  use { 'haishanh/night-owl.vim', opt = true }
  use { 'mofiqul/vscode.nvim', opt = true }
  use { 'tomasiser/vim-code-dark', opt = true }

  -- statusline
  use { 'kyazdani42/nvim-web-devicons' }
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
    'folke/which-key.nvim',
    config = function()
      require('plugins.which-key')
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
    requires = { 'nvim-lua/plenary.nvim', opt = true },
    config = function()
      require('plugins.telescope')
    end
  }

  use {
    'nvim-telescope/telescope-symbols.nvim',
    after = 'telescope.nvim'
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
    cmd = 'Vista'
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'plugins.lspconfig'
    end
  }

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      {
        'l3mon4d3/luasnip',
        requires = { 'rafamadriz/friendly-snippets' },
        config = function()
          require('plugins.luasnip')
        end
      },
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('plugins.cmp')
    end
  }
  use 'onsails/lspkind-nvim'

  -- github copilot
  use {
    'github/copilot.vim',
    config = function()
      require('plugins.copilot')
    end
  }

  use {
    'sbdchd/neoformat',
    config = function()
      require('plugins.neoformat')
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
  use 'tweekmonster/startuptime.vim'
  -- use 'dstein64/vim-startuptime'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
