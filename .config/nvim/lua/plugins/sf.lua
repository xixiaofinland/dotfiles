return {
  'xixiaofinland/sf.nvim',
  -- dir = '~/projects/sf.nvim',

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    -- keys are defined in after/ftplugins/apex.lua

    -- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    --   callback = function()
    --     require('sf.org').fetch_org_list()
    --   end,
    -- })
  end
}
