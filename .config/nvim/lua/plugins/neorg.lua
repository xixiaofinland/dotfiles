return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    tag = "v7.0.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons
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

      vim.keymap.set("n", "<leader>no", ":vs " .. note_path .. "personal.norg<CR>", { desc = name .. "own file" })
      vim.keymap.set("n", "<leader>nw", ":vs " .. note_path .. "work.norg<CR>", { desc = name .. "work file" })
      vim.keymap.set("n", "<leader>nr", "<CMD>Git pull --all<CR>", { desc = name .. "retrieve all notes" })
      vim.keymap.set("n", "<leader>np", "<CMD>Git commit -am \"+\" | Git push<CR>", { desc = name .. "push all notes" })
      -- vim.keymap.set("n", "<leader>nc", "<CMD>Neorg return<CR>", { desc = name .. "[C]lose all notes" })
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
