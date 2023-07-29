-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })




vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Open file directory' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- My general keys
-- vim.keymap.set('n', '<S-Enter>', 'O<ESC>j', { silent = true })
-- vim.keymap.set('n', '<Enter>', 'o<ESC>k', { silent = true })

-- Salesforce
vim.keymap.set('n', '<leader>sfp', '<C-w>s<C-w>j10<C-w>-:term sf project deploy start  --source-dir "%" --target-org xixiao100<CR>', { desc = 'Apex deploy current file' })


-- vim.keymap.set('n', '<leader>fa', '<C-w>s<C-w>j10<C-w>-:term prettier --plugin=prettier-plugin-apex --write "%" <CR>', { desc = 'Format by cmd' })

-- sf apex generate class
