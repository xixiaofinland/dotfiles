local nmap = function(keys, func, desc)
  if desc then
    desc = '[Sf] ' .. desc
  end
  vim.keymap.set('n', keys, func, { buffer = true, desc = desc })
end

nmap('<leader><leader>', require("sf.term").toggle, "[T]erminal toggle")
nmap('<C-c>', require("sf.term").cancel, "[C]ancel current running command")
