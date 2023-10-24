return {
  'xixiaofinland/sforg.nvim',
  -- {
  --   'sforg.nvim',
  --   dir = "/home/finxxi/projects/sforg.nvim/",
  -- },

  config = function()
    vim.keymap.set('n', '<leader>ss', require("sforg").set, { desc = "set target_org" })
    vim.keymap.set('n', '<leader>sf', require("sforg").fetch, { desc = "fetch orgs info" })
  end

}
