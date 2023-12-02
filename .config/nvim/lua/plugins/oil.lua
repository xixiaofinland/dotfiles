return {
  {
    'stevearc/oil.nvim',
    opts = {},

    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil --float <CR>", { desc = "Open parent directory" })
    end
  }
}
