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

-- open file with cursor in the last location
local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "SFTerm", "fzf" }

local function run()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- vim.cmd [[normal! gg]]
    return
  end

  if vim.fn.line(".") > 1 then
    return
  end

  local last_line = vim.fn.line([['"]])
  local buff_last_line = vim.fn.line("$")

  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = vim.fn.line("w$")
    local win_first_line = vim.fn.line("w0")
    if win_last_line == buff_last_line then
      vim.cmd [[normal! g`"]]
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd [[normal! g`"zz]]
    else
      vim.cmd [[normal! G'"<c-e>]]
    end
  end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
  group = vim.api.nvim_create_augroup('nvim-lastplace', {}),
  callback = run
})
