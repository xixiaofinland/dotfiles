require "xx.globals"         --  See `./lua/xx/globals.lua` for more information.

require "xx.disable_builtin" -- Turn off builtin plugins I do not use.

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
  {
    'force.nvim',
    dir = "/home/finxxi/projects/force.nvim/"
  },

  'tpope/vim-surround',

  'mbbill/undotree',

  'christoomey/vim-tmux-navigator',

  'tpope/vim-sleuth',

  { 'numToStr/Comment.nvim', opts = {} },

  { 'folke/which-key.nvim', opts = {} },

  -- other rplugins that require setups
  { import = 'plugins' },
})

-- [[ my own custom settings ]]
require 'keys'
require 'opts'

-- vim: ts=2 sts=2 sw=2 et
