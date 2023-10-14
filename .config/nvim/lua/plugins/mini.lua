return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.surround').setup()
      require('mini.cursorword').setup()
      require('mini.ai').setup()
      require('mini.bufremove').setup({
        silent = true,
        vim.keymap.set('n', '<leader>b', require'mini.bufremove'.delete, { desc = 'remove current buffer' })
      })
    end,
  }
}
