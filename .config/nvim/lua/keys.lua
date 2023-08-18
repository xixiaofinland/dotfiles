-- See `:help vim.keymap.set()`
--
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- copied from ThePrimeGen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'paste without losing the copy' })

-- test if this is needed in macOS?
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- Diagnostic keymaps

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- My general keys

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Open file directory' })

vim.keymap.set('n', ']<Space>', ':<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<CR>',
  { silent = true, noremap = true })
vim.keymap.set('n', '[<Space>', ':<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>',
  { silent = true, noremap = true })

-- See `:help telescope.builtin`

local tel = require('telescope.builtin')

vim.keymap.set('n', '<leader>?', tel.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tel.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  tel.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>fi', tel.git_files, { desc = '[F]ind g[I]t files' })
vim.keymap.set('n', '<leader>ff', tel.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', tel.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', tel.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', tel.live_grep, { desc = '[F]ind by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', tel.diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set("n", "<leader>z", require("telescope").extensions.zoxide.list, { desc = 'Z jump' })


-- open file_browser with the path of the current buffer
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fB', ':Telescope file_browser<CR>', { noremap = true })

-- Salesforce keys

vim.keymap.set('n', '<leader>sfp',
  '<C-w>s<C-w>j10<C-w>-:term sf project deploy start  --source-dir "%" --target-org xixiao100<CR>',
  { desc = 'Apex deploy current file' })

vim.keymap.set('n', '<leader>sff',
  ':!npm run prettier -- --plugin=prettier-plugin-apex --write "%"<CR>',
  { desc = 'Prettier local format' })

-- vim.keymap.set('n', '<leader>fa', '<C-w>s<C-w>j10<C-w>-:term prettier --plugin=prettier-plugin-apex --write "%" <CR>', { desc = 'Format by cmd' }
