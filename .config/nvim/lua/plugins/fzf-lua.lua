return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({})

            local nmap = function(keys, func, desc)
                if desc then
                    desc = desc .. ' [Fzf]'
                end
                vim.keymap.set('n', keys, func, { desc = desc })
            end

            local fzf = require('fzf-lua')
            nmap('<leader>ff', fzf.files, 'files')
            nmap('<leader>fr', fzf.resume, 'resume')
            nmap('<leader>fd', fzf.diagnostics_document, 'diagnostics')
            nmap('<leader>fD', function() fzf.files({ cwd = vim.fn.stdpath 'config' }) end, 'dotfiles')
            nmap('<leader>fb', fzf.buffers, 'buffers')
            nmap('<leader>.', fzf.oldfiles, 'recent files')
            nmap('<leader>fg', fzf.grep, 'grep')
            nmap('<leader>fw', fzf.grep_cword, 'word in project')
            nmap('<leader>fW', fzf.grep_cWORD, 'word in current')
            nmap("<leader>fm", fzf.lsp_document_symbols, 'method list')
            nmap('<leader>/', fzf.grep_curbuf, 'search current buffer')
            nmap('<leader>fc', fzf.command_history, 'command history')
            nmap('<leader>fh', fzf.helptags, 'help')
            nmap('<leader>gf', fzf.git_files, 'git files')
            nmap('<leader>gc', fzf.git_commits, 'git commits')
            nmap('<leader>gC', fzf.git_bcommits, 'git commits this buffer')
            nmap('<leader>gb', fzf.git_branches, 'git branches')

            vim.keymap.set('x', '<leader>fv', fzf.grep_visual, {desc = 'visual grep [Fzf]'})

        end
    }
}
