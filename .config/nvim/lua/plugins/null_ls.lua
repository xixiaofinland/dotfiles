return {
  "jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- not work global prettier :(
        -- null_ls.builtins.formatting.prettier.with({
        --     filetypes = { "apex" },
        --     extra_args = { "--plugin=prettier-plugin-apex", "--write" },
        -- }),

        null_ls.builtins.diagnostics.pmd.with({
          filetypes = { "apex" },
          extra_args = {
            "check",
            "--rulesets",
            "apex_ruleset.xml" -- or path to self-written ruleset
          },
        }),
      }
    })
  end,
}

