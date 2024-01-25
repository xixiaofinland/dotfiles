return {
  'xixiaofinland/sf.nvim',
  -- dir = '~/projects/sf.nvim',
  config = function()
    local nmap = function(keys, func, desc)
      if desc then
        desc = '[Sf] ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    -- keys are defined in after/ftplugins/apex.lua

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function()
        require("sf.org").fetch()
      end,
    })
  end
}
