return {
  -- {
  --   'sfterm.nvim',
  --   dir = "/home/finxxi/projects/sfterm.nvim/",
  'xixiaofinland/sfterm.nvim',
  config = function()
    local nmap = function(keys, func, desc)
      if desc then
        desc = '[SfT] ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    nmap('<leader><leader>t', require("sfterm").toggle, "[T]erminal toggle")
    nmap('<leader>sp', require("sfterm").saveAndPush, "[P]ush current file")
    nmap('<leader>sr', require("sfterm").retrieve, "[R]etrieve current file")
  end
  -- end
  -- },
}
