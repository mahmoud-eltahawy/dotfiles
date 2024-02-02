local plugins = {
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "rose-pine/neovim", name = "rose-pine" },
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  'L3MON4D3/LuaSnip',
  "folke/neodev.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',
}

local opts = {}

require("lazy").setup(plugins,opts)
