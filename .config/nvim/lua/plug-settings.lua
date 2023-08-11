local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- global prettier + local prettier-plugin-apex
        -- make sure the package.json has correct version saved
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "apex" },
            extra_args = { "--plugin=prettier-plugin-apex", "--write" },
        }),
    },
})

require('chartoggle').setup ({
          leader = '<localleader>', -- you can use any key as Leader
          keys = {',', ';' } -- Which keys will be toggle end of the line
})
