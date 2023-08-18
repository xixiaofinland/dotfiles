return{
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      -- autoformat in save
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
  },

  {
    "jose-elias-alvarez/null-ls.nvim"
  },

  'saifulapm/chartoggle.nvim',

  'tpope/vim-surround',

  'mbbill/undotree',

  -- Seamless with Tmux
  'christoomey/vim-tmux-navigator',

  'jvgrootveld/telescope-zoxide',

}
