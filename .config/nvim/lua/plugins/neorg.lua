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
          ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
          ["core.integrations.nvim-cmp"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                personal = "~/notes/personal",
                work = "~/notes/work",
              },
              -- default_workspace = "personal",
            },
          },
        },
      }

      local name = "[neorg] "
      -- vim.keymap.set("n", "<leader>ni", "<CMD>Neorg index<CR>", { desc = name .. "[I]ndex" })
      vim.keymap.set("n", "<leader>nc", "<CMD>Neorg return<CR>", { desc = name .. "[C]lose all" })
      vim.keymap.set("n", "<leader>nt", "<CMD>Neorg workspace personal<CR>", { desc = name .. "[T]o-Do file" })
      vim.keymap.set("n", "<leader>nw", "<CMD>Neorg workspace work<CR>", { desc = name .. "[W]ork file" })
    end,
  }
}
