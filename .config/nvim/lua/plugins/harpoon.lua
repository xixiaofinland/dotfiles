return {
  'ThePrimeagen/harpoon',
  config = function()
    vim.keymap.set("n", "<leader>ht", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle Harpoon Menu" })
    vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Add file to harpoon list" })
  end
}
