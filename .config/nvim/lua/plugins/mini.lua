return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.surround').setup()

      local ai = require("mini.ai");
      ai.setup({
        custom_textobjects = {
          a = ai.gen_spec.argument({ brackets = { '%b()' } }),
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      })

      require('mini.bufremove').setup({
        silent = true,
      })

      -- require('mini.pairs').setup()
      -- require('mini.cursorword').setup()

      vim.keymap.set('n', '<leader>b', require 'mini.bufremove'.delete, { desc = 'remove current buffer' })
    end,
  }
}
