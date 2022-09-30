local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
     'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'hoob3rt/lualine.nvim' -- Statusline
  use 'L3MON4D3/LuaSnip' -- Snippets
  use 'neovim/nvim-lspconfig' -- LSP
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'ap/vim-css-color' -- css hex color codes
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'norcalli/nvim-colorizer.lua' 
  use 'lewis6991/gitsigns.nvim' 
  use 'nvim-lua/plenary.nvim' -- common utilities
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'wuelnerdotexe/vim-astro'
end)
