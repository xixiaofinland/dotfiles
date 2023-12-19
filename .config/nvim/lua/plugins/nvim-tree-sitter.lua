return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "apex", "rust", "soql", "sosl", "lua", "vim", "vimdoc" },
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
