-- General for Nvim

-- Solve two jumping issues using relative line-num in one go:
-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- https://www.reddit.com/r/neovim/comments/1b4xefk/comment/kt5n8xl/
vim.keymap.set('n', 'k', [[(v:count > 1 ? "m'" . v:count : "g") . 'k']], { expr = true })
vim.keymap.set('n', 'j', [[(v:count > 1 ? "m'" . v:count : "g") . 'j']], { expr = true })

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without losing the copy' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', ']<Space>', ':<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<CR>',
  { desc = 'Add empty line below', silent = true, noremap = true })
vim.keymap.set('n', '[<Space>', ':<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>',
  { desc = 'Add empty line above', silent = true, noremap = true })

-- My own habit;

vim.keymap.set('n', '<leader>fn', function() return ':e ' .. vim.fn.expand '%:p:h' .. '/' end,
  { expr = true, desc = 'New a file' })

vim.keymap.set('n', '<leader>cf', function()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg('*', file_name)
  vim.notify(string.format('"%s" copied.', file_name), vim.log.levels.INFO)
end, { desc = 'Copy file name' })

vim.keymap.set('n', '<leader>cF', function()
  local file_name = vim.fn.expand("%:p")
  vim.fn.setreg('*', file_name)
  vim.notify(string.format('"%s" copied.', file_name), vim.log.levels.INFO)
end, { desc = 'Copy File name full path' })

vim.keymap.set('n', '<leader>e', '<CMD>e ~/.config/nvim/lua/plugins/sf.lua<CR>',
  { desc = 'Open sf config' })

vim.keymap.set("n", "<Leader>tl",
  function()
    local curr = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({
      virtual_text = not curr
    })
  end, { desc = "toggle virtual text" })
