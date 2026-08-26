return {
    -- Manage the language servers themselves from inside Neovim.
    { 'mason-org/mason.nvim' },
    { 'mason-org/mason-lspconfig.nvim' },

    -- Ships the `lsp/*.lua` server definitions that vim.lsp.config() builds on.
    { 'neovim/nvim-lspconfig' },

    -- Completion.
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
}
