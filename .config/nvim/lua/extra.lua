-- TODO: how to get it in lua? This not work: vim.opt.formatoptions = { c = false, r = false, o = false }
-- new line doesn't continue comment
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

-- Highlight on yank is supplied by mini.basic already;

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
local ignore_filetype = { "gitcommit", "gitrebase", "SFTerm", "fzf", "hgcommit" }

local function run()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    vim.cmd [[normal! gg]]
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

-- personal notes;

local note_path = vim.fn.expand("~/notes/")
vim.keymap.set("n", "<leader>no", ":vs " .. note_path .. "personal.txt<CR>", { desc = "open personal note" })
vim.keymap.set("n", "<leader>nw", ":vs " .. note_path .. "work.txt<CR>", { desc = "open work note" })

local push_cmd = "cd " .. note_path .. "; git commit -am \"+\"; git push;"
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart(push_cmd, { detach = true })
  end,
})

local pull_cmd = "cd " .. note_path .. "; git pull;"
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.fn.jobstart(pull_cmd, {
      stdout_buffered = true,
      on_exit =
          function(_, code)
            if code == 0 then
              vim.notify('note pull success!', vim.log.levels.INFO)
            else
              vim.notify('note pull failed?', vim.log.levels.ERROR)
            end
          end,
    })
  end,
})
