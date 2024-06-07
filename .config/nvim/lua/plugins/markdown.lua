return {
  'MeanderingProgrammer/markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      headings = { '🐹', '🐎 ', '🐢 ', '🐈 ', '🐔 ', '🐼 ' },
      bullets = { '🔉', '📡', '🎺', '🎷' },
      highlights = {
        heading = {
          backgrounds = {},
        }
      }
    })
    vim.keymap.set('n', '\\m', require('render-markdown').toggle, { desc = 'toggle markdown' })
  end,
}
