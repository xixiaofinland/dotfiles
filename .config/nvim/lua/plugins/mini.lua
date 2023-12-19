return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- require('mini.pairs').setup()
      -- require('mini.cursorword').setup()
      require('mini.surround').setup()
      require('mini.trailspace').setup()

      local gen_spec = require("mini.ai").gen_spec;
      require("mini.ai").setup({
        custom_textobjects = {
          a = gen_spec.argument({ brackets = { '%b()' } }), -- match only within `()`
          n = gen_spec.treesitter({ a = "@meth_name", i = "@meth_name" }, {}),
          f = gen_spec.treesitter({ a = '@call.outer', i = '@call.inner' }),
          m = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to }
          end
        },
      })

      require('mini.bracketed').setup({
        -- See `:h MiniBracketed.config` for more info.
        buffer     = { suffix = 'b', options = {} },
        comment    = { suffix = 'c', options = {} },
        conflict   = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'd', options = {} },
        indent     = { suffix = 'i', options = {} },
        jump       = { suffix = 'j', options = {} },
        location   = { suffix = 'l', options = {} },
        quickfix   = { suffix = 'q', options = {} },
        treesitter = { suffix = 't', options = {} },
        file       = { suffix = 'f', options = {} },
        oldfile    = { suffix = 'o', options = {} },
        yank       = { suffix = 'y', options = {} },

        -- disabled ones which I don't use
        undo       = { suffix = '', options = {} },
        window     = { suffix = '', options = {} },

      })

      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      require('mini.bufremove').setup({
        silent = true,
      })

      vim.keymap.set('n', '<leader>b', require'mini.bufremove'.delete, { desc = 'remove current buffer' })
      vim.keymap.set('n', '<leader>mt', MiniTrailspace.trim, { desc = 'Trim all empty space' })
      vim.keymap.set('n', '<leader>ml', MiniTrailspace.trim_last_lines, { desc = 'Trim empty ending lines' })
    end,
  }
}
