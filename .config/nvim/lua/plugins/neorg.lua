return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    -- tag = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }

      local name = "[neorg] "
      vim.keymap.set("n", "<leader>ni", "<CMD>Neorg index<CR>", { desc = name .. "[I]ndex" })
      vim.keymap.set("n", "<leader>nc", "<CMD>Neorg return<CR>", { desc = name .. "[C]lose all" })
      vim.keymap.set("n", "<leader>nt",  function() return ':e ' .. vim.fn.expand '~' .. '/notes/to-do.norg<CR>' end, { expr = true, desc = name .. "[T]o-do file" })
      vim.keymap.set("n", "<leader>nw",  function() return ':e ' .. vim.fn.expand '~' .. '/notes/work.norg<CR>' end, { expr = true, desc = name .. "[W]ork file" })
    end,
  }
}
