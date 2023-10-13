--  NOTE: Must happen earlier than lazy
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install lazy
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
  'xixiaofinland/sforg.nvim',
  -- {
  --   'sforg.nvim',
  --   dir = "/home/finxxi/projects/sforg.nvim/",
  -- },

  'nvim-tree/nvim-web-devicons',

  'tpope/vim-surround',

  'christoomey/vim-tmux-navigator',

  'tpope/vim-sleuth',

  { 'numToStr/Comment.nvim', opts = {} },

  { 'folke/which-key.nvim',  opts = {} },

  -- other plugins that require setups
  { import = 'plugins' },
})

-- [[ my own custom settings ]]
require "globals"
require 'keys'
require 'opts'

-- vim: ts=2 sts=2 sw=2 et
