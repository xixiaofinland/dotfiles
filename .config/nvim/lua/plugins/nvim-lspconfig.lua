return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true, opts = {} },
    'williamboman/mason-lspconfig.nvim',
    "hrsh7th/cmp-nvim-lsp",
    { 'j-hui/fidget.nvim',       opts = {} },
    { 'folke/neodev.nvim',       opts = {} },
  },
  config = function()
    local on_attach = function(client, bufnr)
      local toggleInlay = function()
        if client.server_capabilities.inlayHintProvider then
          local current_value = vim.lsp.inlay_hint.get({ bufnr = 0 })[1]
          vim.lsp.inlay_hint.enable(bufnr, not current_value)
        end
      end

      local nmap = function(keys, func, desc)
        if desc then
          desc = desc .. ' [LSP]'
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>ti', toggleInlay, 'toggle inlay hint')
      nmap('<leader>rn', vim.lsp.buf.rename, 'rename')
      nmap('<leader>ca', vim.lsp.buf.code_action, 'code action')
      nmap('K', vim.lsp.buf.hover, 'hover doc')
      -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
      -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gd', vim.lsp.buf.definition, 'goto definition')
      nmap('gD', vim.lsp.buf.declaration, 'goto declaration')
      nmap('<leader>fp', function(_)
        -- So Apex formatting doesn't timeout
        vim.lsp.buf.format({ timeout_ms = 2500 })
      end, 'format file')
    end

    -- Enable the following language servers in Mason
    local servers = {
      rust_analyzer = {},
      lua_ls = {
        Lua = {
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true)
          },
          telemetry = { enable = false },
          diagnostics = {
            globals = { 'vim' },
            -- disable = { 'missing-fields' }
          }
        },
      },
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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

    -- `mason_lspconfig.setup_handlers` doesn't handle apex_ls automaticlally (why not?), we need to manually attach below actions
    local lspconfig = require 'lspconfig'
    lspconfig.apex_ls.setup {
      apex_enable_semantic_errors = false,
      apex_enable_completion_statistics = false,
      filetypes = { 'apex' },
      root_dir = lspconfig.util.root_pattern('sfdx-project.json'),

      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
}
