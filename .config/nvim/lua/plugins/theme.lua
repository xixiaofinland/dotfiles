return {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    vim.o.background = "dark" -- or "light" for light mode
    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
