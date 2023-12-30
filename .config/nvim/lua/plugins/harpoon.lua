return {
  'ThePrimeagen/harpoon',
  config = function()
    local name = "[Harp] "
    vim.keymap.set("n", "<leader>ht", require("harpoon.ui").toggle_quick_menu, { desc = name .. "Toggle Harpoon Menu" })
    vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = name .. "Add file to harpoon list" })
    for pos = 0, 9 do
      vim.keymap.set("n", "<leader>h" .. pos, function()
        require("harpoon.ui").nav_file(pos)
      end, { desc = name .. "Move to mark #" .. pos })
    end
  end
}
