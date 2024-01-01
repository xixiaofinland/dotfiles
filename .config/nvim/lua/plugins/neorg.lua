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
      vim.keymap.set("n", "<leader>no", "<CMD>Neorg workspace personal<CR>", { desc = name .. "[O]wn file" })
      vim.keymap.set("n", "<leader>nw", "<CMD>Neorg workspace work<CR>", { desc = name .. "[W]ork file" })

      vim.keymap.set("n", "<leader>nc", "<CMD>Neorg return<CR>", { desc = name .. "[C]lose all notes" })
      vim.keymap.set("n", "<leader>np", "<CMD>Git commit -am \"+\" | Git push<CR>", { desc = name .. "[P]ush all notes" })
      vim.keymap.set("n", "<leader>nr", "<CMD>Git pull --all<CR>", { desc = name .. "[R]etrieve all notes" })
    end,
  }
}
