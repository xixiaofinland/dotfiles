return {
  -- "sainnhe/gruvbox-material",
  -- priority = 1000,
  -- config = function()
  --   vim.o.background = "dark" -- or "light" for light mode
  --   vim.cmd.colorscheme 'gruvbox-material'
  -- end,

  "rebelot/kanagawa.nvim",
  config = function()
    vim.cmd("colorscheme kanagawa-wave")
    -- vim.cmd("colorscheme kanagawa-dragon")
    -- vim.cmd("colorscheme kanagawa-lotus")
  end
}
