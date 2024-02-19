return {
  {
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set('n', '<leader>hv', vim.cmd.DiffviewOpen, { desc = '[Diffv] Open' })
      vim.keymap.set('n', '<leader>hc', vim.cmd.DiffviewClose, { desc = '[Diffv] Close' })
    end
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
    end
  },

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
        local name = "[GitS] "
        vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { buffer = bufnr, desc = name .. 'previous hunk' })
        vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { buffer = bufnr, desc = name .. 'next hunk' })

        vim.keymap.set('n', '<leader>hh', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = name .. 'preview [H]unk' })
        vim.keymap.set('n', '<leader>hs', require('gitsigns').stage_hunk,
          { buffer = bufnr, desc = name .. '[s]tage_hunk' })
        vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk,
          { buffer = bufnr, desc = name .. '[U]ndo_stage_hunk' })
        vim.keymap.set('n', '<leader>hS', require('gitsigns').stage_buffer,
          { buffer = bufnr, desc = name .. '[S]tage_buffer' })
        vim.keymap.set('n', '<leader>tb', require('gitsigns').toggle_current_line_blame,
          { buffer = bufnr, desc = name .. '[B]lame toggle' })
      end,
    },
  }
}
