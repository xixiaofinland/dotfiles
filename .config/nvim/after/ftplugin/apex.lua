vim.bo.commentstring = '//%s'

local nmap = function(keys, func, desc)
  if desc then
    desc = '[Sf] ' .. desc
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end

nmap('<leader>ss', require("sf.org").set, "[s]et target_org current workspace")
nmap('<leader>sS', require("sf.org").setGlobal, "[S]et target_org globally")
nmap('<leader>sf', require("sf.org").fetch, "[F]etch orgs info")

nmap('<leader>t', require("sf.term").toggle, "[T]erminal toggle")
nmap('<leader>sp', require("sf.term").saveAndPush, "[P]ush current file")
nmap('<leader>sr', require("sf.term").retrieve, "[R]etrieve current file")
nmap('<leader>sc', require("sf.term").cancel, "[C]ancel current running command")
nmap('<leader>sta', require("sf.term").runAllTestsInCurrentFile, "[T]est [A]ll")
nmap('<leader>stt', require("sf.term").runCurrentTest, "[T]est [T]his under cursor")
