return {
  'ThePrimeagen/harpoon',
  config = function()
    vim.keymap.set("n", "<leader>ht", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle Harpoon Menu" })
    vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Add file to harpoon list" })
    for pos = 0, 9 do
      vim.keymap.set("n", "<leader>h" .. pos, function()
        require("harpoon.ui").nav_file(pos)
      end, { desc = "Move to harpoon mark #" .. pos })
    end
  end
}
