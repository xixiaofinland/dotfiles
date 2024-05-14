return {
  'xixiaofinland/sf.nvim',
  branch = 'dev',
  -- dir = '~/projects/sf.nvim',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    "ibhagwan/fzf-lua",
  },

  config = function()
    require('sf').setup()
  end
}
