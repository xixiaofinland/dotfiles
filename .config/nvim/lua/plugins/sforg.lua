return {
  'xixiaofinland/sforg.nvim',
  -- {
  --   'sforg.nvim',
  --   dir = "/home/finxxi/projects/sforg.nvim/",
  config = function()
    local nmap = function(keys, func, desc)
      if desc then
        desc = '[SfO] ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    nmap('<leader>ss', require("sforg").set,  "[s]et target_org current workspace" )
    nmap('<leader>sS', require("sforg").setGlobal,  "[S]et target_org globally" )
    nmap('<leader>sf', require("sforg").fetch,  "[F]etch orgs info" )
  end
  -- },
}
