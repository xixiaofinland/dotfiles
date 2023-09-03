-- --  See `./lua/xx/globals.lua` for more information.
require "xx.globals"

-- Turn off builtin plugins I do not use.
require "xx.disable_builtin"

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  {
    'salesforce',
    dir = "/home/finxxi/projects/salesforce.nvim/"
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',          opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = 'previous hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'next hunk' })
        vim.keymap.set('n', '<leader>hh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'preview hunk' })
        vim.keymap.set('n', '<leader>ha', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'stage_hunk' })
        vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk,
          { buffer = bufnr, desc = 'undo_stage_hunk' })
        vim.keymap.set('n', '<leader>hS', require('gitsigns').stage_buffer, { buffer = bufnr, desc = 'stage_buffer' })
        vim.keymap.set('n', '<leader>hb', require('gitsigns').toggle_current_line_blame,
          { buffer = bufnr, desc = 'toggle line blame' })
      end,
    },
  },

  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'gruvbox-material',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        -- lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = false,
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  -- other plugins;
  { import = 'plugins' },
}, {})

-- See `:help telescope.builtin`

local tel = require('telescope.builtin')

vim.keymap.set('n', '<leader>?', tel.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tel.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  tel.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>fi', tel.git_files, { desc = '[F]ind g[I]t files' })
vim.keymap.set('n', '<leader>ff', tel.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', tel.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', tel.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fc', tel.command_history, { desc = '[C]ommand history' })
vim.keymap.set('n', '<leader>fg', tel.live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fl', tel.git_commits, { desc = 'git log' })
-- open file_browser with the path of the current buffer
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fB', ':Telescope file_browser<CR>', { noremap = true })
-- zoxide jump support
vim.keymap.set("n", "<leader>z", require("telescope").extensions.zoxide.list, { desc = 'Z jump' })
-- vim.keymap.set('n', '<leader>sd', tel.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ my own custom settings ]]
require 'keys'
require 'opts'
require 'plug-settings'

-- vim: ts=2 sts=2 sw=2 et
