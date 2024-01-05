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
                notes = "~/notes/",
              },
              default_workspace = "notes",
            },
          },
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                -- remove create new org file hotkey
                keybinds.unmap("norg", "n", keybinds.leader .. "nn")
              end,
            }
          },
        }
      }

      local name = "[neorg] "
      local note_path = vim.fn.expand("~/notes/")

      vim.keymap.set("n", "<leader>no", ":e" .. note_path .. "personal.norg<CR>", { desc = name .. "[O]wn file" })
      vim.keymap.set("n", "<leader>nw", ":e" .. note_path .. "work.norg<CR>", { desc = name .. "[W]ork file" })
      vim.keymap.set("n", "<leader>nc", "<CMD>Neorg return<CR>", { desc = name .. "[C]lose all notes" })
      vim.keymap.set("n", "<leader>nr", "<CMD>Git pull --all<CR>", { desc = name .. "[R]etrieve all notes" })
      vim.keymap.set("n", "<leader>np", "<CMD>Git commit -am \"+\" | Git push<CR>", { desc = name .. "[P]ush all notes" })
      -- vim.keymap.set("n", "<leader>ni", "<CMD>Neorg index<CR>", { desc = name .. "[I]ndex" })

      local push_cmd = "cd " .. note_path .. "; git commit -am \"+\"; git push;"
      vim.api.nvim_create_autocmd({ "VimLeave" }, {
        callback = function()
          vim.fn.jobstart(push_cmd, { detach = true })
        end,
      })

      local pull_cmd = "cd " .. note_path .. "; git pull;"
      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          vim.fn.jobstart(pull_cmd, {
            stdout_buffered = true,
            on_exit =
                function(_, code)
                  if code == 0 then
                    vim.notify('note pull success!', vim.log.levels.INFO)
                  else
                    vim.notify('note pull failed?', vim.log.levels.ERROR)
                  end
                end,
          })
        end,
      })
    end,
  }
}
