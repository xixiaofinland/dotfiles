return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "tris203/precognition.nvim",
    config = {
      startVisible = false,
    }
  },
  vim.keymap.set('n', '\\k', function()
    require("precognition").toggle()
    -- vim.cmd('Hardtime toggle')
  end, { noremap = true, silent = true, desc = 'toggle key-study features' })
}
