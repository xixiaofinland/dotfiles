-- General for Nvim

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'paste without losing the copy' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', ']<Space>', ':<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<CR>',
  { desc = 'add empty line below', silent = true, noremap = true })
vim.keymap.set('n', '[<Space>', ':<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>',
  { desc = 'add empty line above', silent = true, noremap = true })

-- My own habit

vim.keymap.set('n', '<leader>fn', function() return ':e ' .. vim.fn.expand '%:p:h' .. '/' end,
  { expr = true, desc = '[N]ew the current file path in ex' })

vim.keymap.set('n', '<leader>cf', function()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg('*', file_name)
  vim.notify(string.format('"%s" copied.', file_name), vim.log.levels.INFO)
end, { desc = '[c]opy [f]ile name' })

vim.keymap.set('n', '<leader>cF', function()
  local file_name = vim.fn.expand("%:p")
  vim.fn.setreg('*', file_name)
  vim.notify(string.format('"%s" copied.', file_name), vim.log.levels.INFO)
end, { desc = '[c]opy [f]ile name full path' })

vim.keymap.set('n', '<leader>e', '<CMD>e ~/.config/nvim/lua/plugins/sf.lua<CR>',
  { desc = 'Open sf.nvim plugin config file' })

-- test if this is needed in macOS?
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- seldomly used
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- it equals to telescope <leader>d
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
