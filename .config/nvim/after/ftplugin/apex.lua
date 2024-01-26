vim.bo.commentstring = '//%s'

local nmap = function(keys, func, desc)
  if desc then
    desc = '[Sf] ' .. desc
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end

nmap('<leader>ss', require("sf.org").set, "[s]et target_org current workspace")
nmap('<leader>sS', require("sf.org").set_global, "[S]et target_org globally")
nmap('<leader>sf', require("sf.org").fetch, "[F]etch orgs info")
nmap('<leader>sd', require("sf.org").diff_in_target_org, "[d]iff with target_org")
nmap('<leader>sD', require("sf.org").diff_in, "[D]iff with org...")

nmap('<leader><leader>', require("sf.term").toggle, "[T]erminal toggle")

nmap('<leader>sp', require("sf.term").saveAndPush, "[P]ush current file")
nmap('<leader>sr', require("sf.term").retrieve, "[R]etrieve current file")

nmap('<C-c>', require("sf.term").cancel, "[C]ancel current running command")
nmap('<leader>se', require("sf.term").scrollToEnd, "[E]nd scroll in terminal")

nmap('<leader>ta', require("sf.term").runAllTestsInCurrentFile, "[T]est [A]ll")
nmap('<leader>tt', require("sf.term").runCurrentTest, "[T]est [T]his under cursor")
--
nmap('<leader>to', require("sf.test").open, "[T]est [O]pen Buf Select")
nmap('<leader>tr', require("sf.term").repeatLastTests, "[T]est [R]epeat")
