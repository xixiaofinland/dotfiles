return {
  -- {
  --   'sfterm.nvim',
  --   dir = "/home/finxxi/projects/sfterm.nvim/",
  'xixiaofinland/sfterm.nvim',
  config = function()
    vim.keymap.set('n', '<leader>t', require("sfterm").toggle, { desc = "Toggle terminal" })
    vim.keymap.set('n', '<leader>sp', require("sfterm").saveAndPush, { desc = "Sf: push current file" })
    vim.keymap.set('n', '<leader>sr', require("sfterm").retrieve, { desc = "Sf: retrieve current file" })
  end
  -- },
}
