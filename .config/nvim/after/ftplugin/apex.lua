vim.bo.commentstring = '//%s'

local nmap = function(keys, func, desc)
  if desc then
    desc = '[Sf] ' .. desc
  end
  vim.keymap.set('n', keys, func, { buffer = true, desc = desc })
end

nmap('<leader>ss', require("sf.org").set_target_org, "[s]et target_org current workspace")
nmap('<leader>sS', require("sf.org").set_global_target_org, "[S]et global target_org")

nmap('<leader>sf', require("sf.org").fetch_org_list, "[F]etch orgs info")

nmap('<leader>sd', require("sf.org").diff_in_target_org, "[d]iff in target_org")
nmap('<leader>sD', require("sf.org").select_org_to_diff_in, "[D]iff in org...")

nmap('<leader>mr', require("sf.org").retrieve_metadata_list, "[m]etadata [r]etrieve")
nmap('<leader>mp', require("sf.org").select_apex_to_retrieve, "[m]etadata [p]ick and retrieve")

nmap('<leader><leader>', require("sf.term").toggle, "[T]erminal toggle")

nmap('<leader>s-', require("sf.term").go_to_sf_root, "CD into [R]oot")
nmap('<C-c>', require("sf.term").cancel, "[C]ancel current running command")

nmap('<leader>sp', require("sf.term").save_and_push, "[P]ush current file")
nmap('<leader>sr', require("sf.term").retrieve, "[R]etrieve current file")

nmap('<leader>ta', require("sf.term").run_all_tests_in_this_file, "[T]est [A]ll")
nmap('<leader>tt', require("sf.term").run_current_test, "[T]est [T]his under cursor")

nmap('<leader>to', require("sf.test").open, "[T]est [O]pen Buf Select")
nmap('<leader>tr', require("sf.term").repeat_last_tests, "[T]est [R]epeat")

-- nmap('<leader>se', require("sf.term").scrollToEnd, "[E]nd scroll in terminal")

