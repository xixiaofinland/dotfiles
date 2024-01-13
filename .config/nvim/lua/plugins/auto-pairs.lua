return {
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup({
            fast_wrap = {
                map = '<M-e>',
            }
        })
    end
}
