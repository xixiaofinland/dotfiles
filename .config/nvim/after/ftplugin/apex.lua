-- Salesforce keys

vim.keymap.set('n', '<leader>sfp',
  '<C-w>s<C-w>j10<C-w>-:term sf project deploy start  --source-dir "%" --target-org xixiao100<CR>',
  { desc = 'Apex deploy current file' })

vim.keymap.set('n', '<leader>sff',
  ':!npm run prettier -- --plugin=prettier-plugin-apex --write "%"<CR>',
  { desc = 'Prettier local format' })

-- vim.keymap.set('n', '<leader>fa', '<C-w>s<C-w>j10<C-w>-:term prettier --plugin=prettier-plugin-apex --write "%" <CR>', { desc = 'Format by cmd' }
