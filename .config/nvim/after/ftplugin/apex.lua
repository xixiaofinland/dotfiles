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

vim.keymap.set('n', '<leader>st',
  ':lua require"sf".setTargetOrg()<CR>',
  { desc = 'Set Target Org' })

vim.keymap.set('n', '<leader>so',
  ':lua require"sf".fetchOrgInfo()<CR>',
  { desc = 'Fetch Org Info' })

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
