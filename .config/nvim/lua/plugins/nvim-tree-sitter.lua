return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "apex", "rust", "soql", "sosl", "lua", "vim", "vimdoc" },
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "ts: outer assignment" },
            ["i="] = { query = "@assignment.inner", desc = "ts: inner ssignment" },
            ["l="] = { query = "@assignment.lhs", desc = "ts: left assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "ts: right assignment" },

            -- ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
            -- ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
            -- ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
            -- ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

            ["aa"] = { query = "@parameter.outer", desc = "ts: outer parameter" },
            ["ia"] = { query = "@parameter.inner", desc = "ts: inner parameter" },

            ["ai"] = { query = "@conditional.outer", desc = "ts: outer conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "ts: inner conditional" },

            ["al"] = { query = "@loop.outer", desc = "ts: outer loop" },
            ["il"] = { query = "@loop.inner", desc = "ts: inner loop" },

            ["af"] = { query = "@call.outer", desc = "ts: outer function-call" },
            ["if"] = { query = "@call.inner", desc = "ts: inner function-call" },

            ["am"] = { query = "@function.outer", desc = "ts: outer definition method/function" },
            ["im"] = { query = "@function.inner", desc = "ts: inner definition method/function" },

            ["ac"] = { query = "@class.outer", desc = "ts: outer class" },
            ["ic"] = { query = "@class.inner", desc = "ts: inner class" },
          },
        },

        swap = {
          enable = true,
          swap_next = {
            ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
            ["<leader>nm"] = "@function.outer",  -- swap function with next
            -- ["<leader>n:"] = "@property.outer",    -- swap object property with next
          },
          swap_previous = {
            ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
            ["<leader>pm"] = "@function.outer",  -- swap function with previous
            ["<leader>p:"] = "@property.outer",  -- swap object property with prev
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]n"] = { query = "@meth_name", desc = "ts: next def method/function name" },
            ["]f"] = { query = "@call.outer", desc = "ts: next call method/function start" },
            ["]m"] = { query = "@function.outer", desc = "ts: next def method/function start" },
            ["]c"] = { query = "@class.outer", desc = "ts: next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "ts: next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "ts: next call method/function end" },
            ["]M"] = { query = "@function.outer", desc = "ts: next def method/function end" },
            ["]C"] = { query = "@class.outer", desc = "ts: next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "ts: next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "ts: next loop end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@meth_name", desc = "ts: next call method/function name" },
            ["[f"] = { query = "@call.outer", desc = "ts: prev call method/function start" },
            -- ["[m"] = { query = "@function.outer", desc = "ts: prev def method/function start" },
            ["[c"] = { query = "@class.outer", desc = "ts: prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "ts: prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "ts: prev loop start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "ts: prev call method/function end" },
            ["[M"] = { query = "@function.outer", desc = "ts: prev def method/function end" },
            ["[C"] = { query = "@class.outer", desc = "ts: prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "ts: prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "ts: prev loop end" },
          },
        },

        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
    })

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  end,
}
