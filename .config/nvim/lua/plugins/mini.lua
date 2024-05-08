return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.files').setup()
      require('mini.comment').setup()
      require('mini.cursorword').setup()
      -- disable highlight of the word under the cursor
      vim.cmd('hi! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE')

      require('mini.surround').setup()
      require('mini.trailspace').setup()
      require('mini.doc').setup()

      local gen_spec = require("mini.ai").gen_spec;
      require("mini.ai").setup({
        custom_textobjects = {
          o = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }, {}),
          m = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          i = gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }, {}),
          -- c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          -- `g` text obj for the entire file
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to }
          end

          -- ts-textobject already defined `a` move
          -- a = gen_spec.argument({ brackets = { '%b()' } }), -- match only within `()`

          -- f = gen_spec.treesitter({ a = '@call.outer', i = '@call.inner' }),
        },
      })

      require('mini.bracketed').setup({
        -- See `:h MiniBracketed.config` for more info.
        buffer     = { suffix = 'b', options = {} },
        indent     = { suffix = 'i', options = {} },
        treesitter = { suffix = 't', options = {} },
        file       = { suffix = 'f', options = {} },
        oldfile    = { suffix = 'o', options = {} },
        yank       = { suffix = 'y', options = {} },
        quickfix   = { suffix = 'q', options = {} },
        jump       = { suffix = 'j', options = {} },
        location   = { suffix = 'l', options = {} },
        conflict   = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'd', options = {} },

        -- disabled ones which I don't use
        comment    = { suffix = '', options = {} },
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

      local nmap = function(keys, func, desc)
        if desc then
          desc = '[Mini] ' .. desc
        end
        vim.keymap.set('n', keys, func, { desc = desc })
      end

      nmap('<leader>b', require 'mini.bufremove'.delete, '[B]uffer delete')
      nmap('<leader>ts', MiniTrailspace.trim, 'Tr[i]m [S]pace')
      nmap('<leader>te', MiniTrailspace.trim_last_lines, 'Tr[i]m [E]nding-line')
    end,
  }
}
