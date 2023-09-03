vim.keymap.set('n', '<leader>sp', ':!sf project deploy start  --source-dir "%"<CR>',
  { desc = '[p]ush this to default org' })

vim.keymap.set('n', '<leader>sP', ':!sf project deploy start  --source-dir "%" --target-org ',
  { desc = '[P]ush this to...' })

vim.keymap.set('n', '<leader>sf', ':!sf project retrieve start  --source-dir "%"<CR>',
  { desc = '[f]etch this from default org' })

vim.keymap.set('n', '<leader>sF', ':!sf project retrieve start  --source-dir "%" --target-org ',
  { desc = '[F] this from...' })

vim.keymap.set('n', '<leader>sk',
  ':!npm run prettier -- --plugin=prettier-plugin-apex --write "%"<CR>',
  { desc = 'Prettier current file' })

-- vim.keymap.set('n', '<leader>fa', '<C-w>s<C-w>j10<C-w>-:term prettier --plugin=prettier-plugin-apex --write "%" <CR>', { desc = 'Format by cmd' }
