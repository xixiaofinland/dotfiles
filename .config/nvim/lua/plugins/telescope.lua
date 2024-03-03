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
    -- overwrite the default previewer by load `sf_type.lua` defined in dotfiles
    require 'plenary.filetype'.add_file('sf_type')

    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
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

    local nmap = function(keys, func, desc)
      if desc then
        desc = '[Tel] ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    nmap('<leader>.', tel.oldfiles, 'Recent files')
    -- nmap("<leader>fm", function() tel.treesitter({ default_text = "method | function " }) end, '[M]ethods list')
    nmap("<leader>fm", function() tel.lsp_document_symbols({ default_text = "method | function " }) end, '[M]ethods list')
    nmap("<leader>ft", tel.treesitter, '[T]reesitter symbols')
    nmap('<leader>fi', tel.git_files, 'g[I]t files')
    nmap('<leader>ff', tel.find_files, '[F]iles')
    nmap('<leader>fh', tel.help_tags, '[H]elp')
    nmap('<leader>fw', tel.grep_string, '[W]ord in current')
    nmap('<leader>fc', tel.command_history, '[C]ommand history')
    nmap('<leader>fg', tel.live_grep, '[G]rep')
    nmap('<leader>fl', tel.git_commits, '[L]og in git')
    nmap("<leader>z", require("telescope").extensions.zoxide.list, '[Z] jump')
    nmap('<leader>fb', function() tel.buffers({ sort_lastused = true, sort_mru = true }) end, 'Current buffers')
    -- nmap('<leader>fd', tel.diagnostics, '[D]iagnostics')

    nmap('<leader>fd', function() tel.find_files({ cwd = vim.fn.stdpath 'config' }) end, '[d]otfiles')
    nmap('<leader>fG', function() tel.grep_string({ cwd = '~/.config/' }) end, '[g]rep dotfiles')

    nmap('<leader>/',
      function()
        tel.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })
      end, 'Fuzzy search in this buffer')
  end,
}
