-- TODO: how to get it in lua? This not work: vim.opt.formatoptions = { c = false, r = false, o = false }
-- new line doesn't continue comment
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

-- Highlight on yank. `:h vim.highlight.on_yank`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
