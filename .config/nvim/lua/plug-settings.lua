-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  -- telescope-file-browser settings
  extensions = {
    file_browser = {
      -- theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Enable telescope-file-browser
require("telescope").load_extension "file_browser"
require("telescope").load_extension('zoxide')

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`

-- vim.treesitter.language.register('java', 'apex')

-- [[ use the open-source parser ]]
-- https://github.com/aheber/tree-sitter-sfapex
-- the parser needs to be built by tree-sitter cli: https://github.com/nvim-treesitter/nvim-treesitter#adding-parsers
-- Also the query files must be manually copied into tree-sitter queries folder (~/.local/share/nvim/lazy/nvim-treesitter/queries), ref below:
-- https://github.com/aheber/tree-sitter-sfapex/issues/14
--
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

parser_config.soql = {
  install_info = {
    url = "~/projects/tree-sitter-sfapex/soql", -- local path or git repo
    files = { "src/parser.c" },
    branch = "main",                            -- default branch in case of git repo if different from master
    generate_requires_npm = false,              -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false,     -- if folder contains pre-generated src/parser.c
  }
}

parser_config.sosl = {
  install_info = {
    url = "~/projects/tree-sitter-sfapex/sosl", -- local path or git repo
    files = { "src/parser.c" },
    branch = "main",                            -- default branch in case of git repo if different from master
    generate_requires_npm = false,              -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false,     -- if folder contains pre-generated src/parser.c
  }
}

require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'lua', 'rust', 'vimdoc', 'vim', 'java', 'apex', 'sosl', 'soql' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
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
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
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
}

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
  nmap('<leader>fp', function(_)
    -- So Apex formatting doesn't timeout
    vim.lsp.buf.format({ timeout_ms = 2500 })
  end, 'Format')

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   -- So Apex formatting doesn't timeout
  --   vim.lsp.buf.format({ timeout = 2500 })
  -- end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers in Mason
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  rust_analyzer = {},
  apex_ls = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- require("mason").setup {}
-- require("mason-lspconfig").setup()
require'lspconfig'.apex_ls.setup {
  -- download apex LSP jar file from official site to user home
  apex_jar_path = os.getenv('HOME') .. '/apex-jorje-lsp.jar',
  apex_enable_semantic_errors = false,       -- Whether to allow Apex Language Server to surface semantic errors
  apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
  filetypes = { 'apex' },
  root_dir = require'lspconfig'.util.root_pattern('sfdx-project.json'),

  -- `mason_lspconfig.setup_handlers` doesn't handle manually configured languages, we need to manually attach below actions
  on_attach = on_attach,
  capabilities = capabilities,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- not work global prettier :(
    -- null_ls.builtins.formatting.prettier.with({
    --     filetypes = { "apex" },
    --     extra_args = { "--plugin=prettier-plugin-apex", "--write" },
    -- }),

    null_ls.builtins.diagnostics.pmd.with({
      filetypes = { "apex" },
      extra_args = {
        "check",
        "--rulesets",
        "apex_ruleset.xml"         -- or path to self-written ruleset
      },
    }),
  }
})

require('chartoggle').setup({
  leader = '<localleader>',         -- you can use any key as Leader
  keys = { ',', ';' }               -- Which keys will be toggle end of the line
})
