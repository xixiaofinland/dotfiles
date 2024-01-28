return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true,  opts = {} },
    'williamboman/mason-lspconfig.nvim',
    "hrsh7th/cmp-nvim-lsp",
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
    { 'folke/neodev.nvim',       opts = {} },
  },
  config = function()
    local on_attach = function(client, bufnr)

      -- Config LSP Inlay Hint
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
      end
      -- vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
      -- vim.api.nvim_create_autocmd("InsertEnter", {
      --   buffer = bufnr,
      --   callback = function() vim.lsp.inlay_hint.enable(bufnr, true) end,
      --   group = "lsp_augroup",
      -- })
      -- vim.api.nvim_create_autocmd("InsertLeave", {
      --   buffer = bufnr,
      --   callback = function() vim.lsp.inlay_hint.enable(bufnr, false) end,
      --   group = "lsp_augroup",
      -- })

      -- Set hotkeys

      local nmap = function(keys, func, desc)
        if desc then
          desc = '[LSP] ' .. desc
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
      end, '[P]retty file')
    end

    -- Enable the following language servers in Mason
    local servers = {
      rust_analyzer = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      tsserver = {},
      -- apex_ls = {},
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

    local lspconfig = require 'lspconfig'
    lspconfig.apex_ls.setup {
      apex_enable_semantic_errors = false,
      apex_enable_completion_statistics = false,
      filetypes = { 'apex' },
      root_dir = lspconfig.util.root_pattern('sfdx-project.json'),

      -- `mason_lspconfig.setup_handlers` doesn't handle manually configured languages, we need to manually attach below actions
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
}
