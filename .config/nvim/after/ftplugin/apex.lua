vim.keymap.set('n', '<leader>sp', ':!sf project deploy start  --source-dir "%" --target-org xixiao100<CR>',
  { desc = 'Deploy current file' })

vim.keymap.set('n', '<leader>sf',
  ':!npm run prettier -- --plugin=prettier-plugin-apex --write "%"<CR>',
  { desc = 'Prettier current file' })

-- vim.keymap.set('n', '<leader>fa', '<C-w>s<C-w>j10<C-w>-:term prettier --plugin=prettier-plugin-apex --write "%" <CR>', { desc = 'Format by cmd' }
