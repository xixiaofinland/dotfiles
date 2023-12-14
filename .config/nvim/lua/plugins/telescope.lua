return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    'jvgrootveld/telescope-zoxide',
    "nvim-telescope/telescope-file-browser.nvim",
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

      -- telescope-file-browser settings
      extensions = {
        file_browser = {
          -- theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
            },
            ["n"] = {
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("zoxide")

    local tel = require('telescope.builtin')

    vim.keymap.set('n', '<leader>?', tel.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', function()
        tel.buffers({ sort_lastused = true, sort_mru = true })
      end,
      { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      tel.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set("n", "<leader>fs", tel.lsp_document_symbols, { desc = 'List [S]ymbols' })
    vim.keymap.set("n", "<leader>fm", function() tel.treesitter({ symbols = { 'function', 'method' } }) end,
      { desc = 'List [M]ethods' })
    vim.keymap.set("n", "<leader>ft", tel.treesitter, { desc = 'List [T]reesitter symbols' })
    vim.keymap.set('n', '<leader>fi', tel.git_files, { desc = '[F]ind g[I]t files' })
    vim.keymap.set('n', '<leader>ff', tel.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fh', tel.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fw', tel.grep_string, { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fc', tel.command_history, { desc = '[C]ommand history' })
    vim.keymap.set('n', '<leader>fg', tel.live_grep, { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fl', tel.git_commits, { desc = 'git log' })
    vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>fB', ':Telescope file_browser<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>fd', tel.diagnostics, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set("n", "<leader>z", require("telescope").extensions.zoxide.list, { desc = 'Z jump' })
  end,
}
