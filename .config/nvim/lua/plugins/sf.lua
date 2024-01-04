return {
  'xixiaofinland/sf.nvim',
  config = function()
    local nmap = function(keys, func, desc)
      if desc then
        desc = '[Sf] ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    nmap('<leader>ss', require("sf.org").set, "[s]et target_org current workspace")
    nmap('<leader>sS', require("sf.org").setGlobal, "[S]et target_org globally")
    nmap('<leader>sf', require("sf.org").fetch, "[F]etch orgs info")

    nmap('<leader><leader>t', require("sf.term").toggle, "[T]erminal toggle")
    nmap('<leader>sp', require("sf.term").saveAndPush, "[P]ush current file")
    nmap('<leader>sr', require("sf.term").retrieve, "[R]etrieve current file")

    local sf_run_all_test = ''
    nmap('<leader>sta', function() require("sf.term").run('echo hello') end, "[T]est [A]ll")

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function()
        require("sf.org").fetch()
      end,
    })
  end
  -- },
}
