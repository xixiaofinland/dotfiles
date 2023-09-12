return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      ensure_installed = { 'lua', 'rust', 'vimdoc', 'vim', 'java', 'apex', 'javascript' },
      -- ensure_installed = { 'lua', 'rust', 'vimdoc', 'vim', 'java', 'apex', 'sosl', 'soql', 'javascript' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']g'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',

            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    })

    -- [[ Apex ]
    -- 1. the parser `parser.c` needs to be built by tree-sitter cli: https://github.com/nvim-treesitter/nvim-treesitter#adding-parsers
    -- 2. the query cmd files are already part of my dotfiles under `nvim/after/queries` folder
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.apex = {
      install_info = {
        url = "~/projects/tree-sitter-sfapex/apex", -- local path or git repo
        files = { "src/parser.c" },                 -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = "main",                            -- default branch in case of git repo if different from master
        generate_requires_npm = false,              -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false,     -- if folder contains pre-generated src/parser.c
      },
    }

    -- parser_config.soql = {
    --   install_info = {
    --     url = "~/projects/tree-sitter-sfapex/soql", -- local path or git repo
    --     files = { "src/parser.c" },
    --     branch = "main",                            -- default branch in case of git repo if different from master
    --     generate_requires_npm = false,              -- if stand-alone parser without npm dependencies
    --     requires_generate_from_grammar = false,     -- if folder contains pre-generated src/parser.c
    --   }
    -- }
    --
    -- parser_config.sosl = {
    --   install_info = {
    --     url = "~/projects/tree-sitter-sfapex/sosl", -- local path or git repo
    --     files = { "src/parser.c" },
    --     branch = "main",                            -- default branch in case of git repo if different from master
    --     generate_requires_npm = false,              -- if stand-alone parser without npm dependencies
    --     requires_generate_from_grammar = false,     -- if folder contains pre-generated src/parser.c
    --   }
    -- }
  end,
}
