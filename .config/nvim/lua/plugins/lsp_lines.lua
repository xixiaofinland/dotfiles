return {
    'lsp_lines.nvim',
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
        require("lsp_lines").setup()

        -- Disable virtual_text since it's redundant now
        vim.diagnostic.config({
            virtual_text = false,
        })

        vim.keymap.set("n", "<Leader>l", require("lsp_lines").toggle, { desc = "[lsp_lines] Toggle lsp_lines" })
    end
}
