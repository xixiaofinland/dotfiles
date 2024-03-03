return {
  'xixiaofinland/sf.nvim',
  branch = 'dev',
  -- dir = '~/projects/sf.nvim',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    require('sf').setup() -- important to call setup() to init the plugin!
  end
}
