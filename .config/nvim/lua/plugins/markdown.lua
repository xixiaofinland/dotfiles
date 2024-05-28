return {
  'MeanderingProgrammer/markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({})
    vim.keymap.set('n', '\\m', require('render-markdown').toggle, { desc = 'toggle markdown' })
  end,
}
