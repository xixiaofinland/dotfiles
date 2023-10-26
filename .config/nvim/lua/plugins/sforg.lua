return {
  'xixiaofinland/sforg.nvim',
  -- {
  --   'sforg.nvim',
  --   dir = "/home/finxxi/projects/sforg.nvim/",
  config = function()
    vim.keymap.set('n', '<leader>ss', require("sforg").set, { desc = "set target_org for the current workspace" })
    vim.keymap.set('n', '<leader>sS', require("sforg").setGlobal, { desc = "set target_org globally" })
    vim.keymap.set('n', '<leader>sf', require("sforg").fetch, { desc = "fetch orgs info" })
  end
  -- },
}
