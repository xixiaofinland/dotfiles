return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      local nmap = function(keys, func, desc)
        if desc then
          desc = desc .. ' [Mini]'
        end
        vim.keymap.set('n', keys, func, { desc = desc })
      end

      require('mini.basics').setup(
        {
          options = {
            extra_ui = true,
          },
          mappings = {
            basic = false,
            windows = true,
            move_with_alt = true,
          },
        }
      )

      require('mini.indentscope').setup({
        options = {
          -- indent_at_cursor = false,
          try_as_border = true,
        },
        mappings = {
          goto_top = '[s',
          goto_bottom = ']s',
        }
      })

      require('mini.indentscope').gen_animation.none()

      require('mini.pick').setup()
      require('mini.comment').setup()
      require('mini.surround').setup()
      require('mini.trailspace').setup()
      require('mini.doc').setup()

      require('mini.cursorword').setup()
      vim.cmd('hi! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE') -- disable highlight of the word under the cursor

      require('mini.misc').setup()
      MiniMisc.setup_restore_cursor({
        ignore_filetype = { "gitcommit", "gitrebase", "SFTerm", "fzf" }
      })

      nmap('<leader>M', MiniMisc.zoom, 'toggle zoom')

      -- MiniMisc.setup_auto_root({ '.git', 'Makefile', ".forceignore", "sfdx-project.json" },
      --   function() vim.notify('Mini find_root failed.', vim.log.levels.WARN) end)


      require('mini.files').setup({
        mappings = {
          synchronize = '-'
        },
        windows = {
          width_focus = 40,
        }
      })

      require('mini.files').setup()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowUpdate',
        callback = function(args)
          vim.wo[args.data.win_id].number = true
          vim.wo[args.data.win_id].relativenumber = true
        end,
      })

      local gen_spec = require("mini.ai").gen_spec;
      require("mini.ai").setup({
        custom_textobjects = {
          m = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to }
          end

          -- these are not in my habit;
          -- o = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }, {}),
          -- i = gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }, {}),
          -- c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          -- `g` text obj for the entire file

          -- ts-textobject already has these defined;
          -- a = gen_spec.argument({ brackets = { '%b()' } }), -- match only within `()`
          -- f = gen_spec.treesitter({ a = '@call.outer', i = '@call.inner' }),
        },
      })

      require('mini.bracketed').setup({
        diagnostic = { suffix = 'd', options = { severity = vim.diagnostic.severity.ERROR } },

        -- disabled ones which I don't use;
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
          hex_color = hipatterns.gen_highlighter.hex_color(), -- Highlight hex color strings (`#rrggbb`) using that color
        },
      })

      require('mini.bufremove').setup({
        silent = true,
      })

      local minifiles_toggle = function(...)
        if not MiniFiles.close() then MiniFiles.open(...) end
      end

      nmap('<leader>o', minifiles_toggle, 'open/close explorer')
      nmap('<leader>b', require'mini.bufremove'.delete, 'buffer delete')
      nmap('<leader>ts', MiniTrailspace.trim, 'trim space')
      nmap('<leader>te', MiniTrailspace.trim_last_lines, 'trim end-line')

      -- toggle hidden files in mini.files;

      local show_dotfiles = true
      local filter_show = function(fs_entry) return true end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end
      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
        end,
      })

      local miniclue = require('mini.clue')
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- No leader keys
          { mode = 'n', keys = '\\' },
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
          { mode = 'n', keys = '<C-w>' },
          { mode = 'n', keys = ']' },
          { mode = 'n', keys = '[' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },
        },

        clues = {
          -- for built-in keys
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.z(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          -- miniclue.gen_clues.g(),
        },

        window = {
          delay = 800,
          config = { width = "auto", border = "single" },
        }
      })
    end,
  }
}
