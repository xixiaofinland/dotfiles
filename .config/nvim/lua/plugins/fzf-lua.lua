return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({})

            local nmap = function(keys, func, desc)
                if desc then
                    desc = '[fzf] ' .. desc
                end
                vim.keymap.set('n', keys, func, { desc = desc })
            end

            local fzf = require('fzf-lua')
            nmap('<leader>ff', fzf.files, '[F]iles')
            nmap('<leader>fr', fzf.resume, '[R]esume')
            nmap('<leader>fd', function() fzf.files({ cwd = vim.fn.stdpath 'config' }) end, '[d]otfiles')
            nmap('<leader>fb', fzf.buffers, 'Current buffers')
            nmap('<leader>.', fzf.oldfiles, 'Recent files')
            nmap('<leader>fg', fzf.grep, '[G]rep')
            nmap('<leader>fw', fzf.grep_cword, '[w]ord in current')
            nmap('<leader>fW', fzf.grep_cWORD, '[W]ord in current')
            nmap('<leader>fv', fzf.grep_visual, '[v]isual select grep')
            nmap("<leader>fm", fzf.lsp_document_symbols, '[M]ethods list')
            nmap('<leader>/', fzf.grep_curbuf, 'search current buffer')
            nmap('<leader>fc', fzf.command_history, '[C]ommand history')
            nmap('<leader>fh', fzf.helptags, '[H]elp')

            nmap('<leader>gf', fzf.git_files, '[g]it [f]iles')
            nmap('<leader>gS', fzf.git_status, '[g]it [s]tatus')
            nmap('<leader>gc', fzf.git_commits, '[g]it [c]ommits')
            nmap('<leader>gC', fzf.git_bcommits, '[g]it [C]ommits this buffer')
            nmap('<leader>gb', fzf.git_branches, '[g]it [b]ranches')

        end
    }
}
