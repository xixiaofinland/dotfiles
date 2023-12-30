return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    'jvgrootveld/telescope-zoxide',
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("zoxide")

    local tel = require('telescope.builtin')

    vim.keymap.set('n', '<leader>?', tel.oldfiles, { desc = '[?] Recent files' })
    vim.keymap.set("n", "<leader>fm", function() tel.treesitter({ default_text = "method | function " }) end,
      { desc = '[M]ethods list' })
    vim.keymap.set("n", "<leader>ft", tel.treesitter, { desc = '[T]reesitter symbols' })
    vim.keymap.set('n', '<leader>fi', tel.git_files, { desc = 'g[I]t files' })
    vim.keymap.set('n', '<leader>ff', tel.find_files, { desc = '[F]iles' })
    vim.keymap.set('n', '<leader>fh', tel.help_tags, { desc = '[H]elp' })
    vim.keymap.set('n', '<leader>fw', tel.grep_string, { desc = '[W]ord in current' })
    vim.keymap.set('n', '<leader>fc', tel.command_history, { desc = '[C]ommand history' })
    vim.keymap.set('n', '<leader>fg', tel.live_grep, { desc = '[G]rep' })
    vim.keymap.set('n', '<leader>fl', tel.git_commits, { desc = '[L]og in git' })
    vim.keymap.set('n', '<leader>fd', tel.diagnostics, { desc = '[D]iagnostics' })
    vim.keymap.set("n", "<leader>z", require("telescope").extensions.zoxide.list, { desc = '[Z] jump' })

    vim.keymap.set('n', '<leader><space>', function()
        tel.buffers({ sort_lastused = true, sort_mru = true })
      end,
      { desc = '[ ] Current buffers' })

    vim.keymap.set('n', '<leader>/', function()
      tel.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzy search in this buffer' })
  end,
}
