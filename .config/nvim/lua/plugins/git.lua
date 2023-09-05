return {
  'sindrets/diffview.nvim',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'lewis6991/gitsigns.nvim', -- See `:help gitsigns.txt`
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = 'previous hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'next hunk' })
        vim.keymap.set('n', '<leader>hh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'preview hunk' })
        vim.keymap.set('n', '<leader>ha', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'stage_hunk' })
        vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk,
          { buffer = bufnr, desc = 'undo_stage_hunk' })
        vim.keymap.set('n', '<leader>hS', require('gitsigns').stage_buffer, { buffer = bufnr, desc = 'stage_buffer' })
        vim.keymap.set('n', '<leader>hb', require('gitsigns').toggle_current_line_blame,
          { buffer = bufnr, desc = 'toggle line blame' })
      end,
    },
  }
}
