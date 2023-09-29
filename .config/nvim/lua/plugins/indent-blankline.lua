return {
  -- See `:help indent_blankline.txt`
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  opts = {
    char = '┊',
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_current_context_start = false,
  },
}
