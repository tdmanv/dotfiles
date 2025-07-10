-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#setup
require("mason").setup()
require("mason-lspconfig").setup {
    -- ensure_installed = { "lua_ls", "gopls", "bashls" },
    ensure_installed = { "lua_ls", "gopls" },
}

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}

local lsp = require('lsp-zero').preset({})

-- Default key bindings are configured here:
-- https://github.com/VonHeikemen/lsp-zero.nvim#keybindings
-- Override key bindings
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#on_attachcallback
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr }) -- add lsp-zero defaults
    local opts = { buffer = bufnr }
    local bind = vim.keymap.set
    -- https://github.com/nvim-telescope/telescope.nvim#file-pickers
    -- https://neovim.io/doc/user/lua.html#vim.keymap.set()
    bind('n', 'gi', function()
        return require("telescope.builtin").lsp_implementations { reuse_win = true }
    end, opts)
    --bind('n', 'gi', '<cmd> lua require("telescope.builtin").lsp_implementations{ reuse_win = true }<cr>', opts)
end)

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
-- Need to install via:
--   npm i -g bash-language-server
-- lsp.setup_servers({ 'bashls' })

-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({ 'gopls' })

-- https://github.com/folke/neodev.nvim
-- require("neodev").setup()

-- (Optional) Configure lua language server for neovim

local lspconfig = require("lspconfig")

-- lspconfig.bashls.setup({})

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.gopls.setup({
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})

local cmp = require('cmp')
cmp.setup({
    mapping = {
        -- For some reason this default doesn't work:
        --["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }
})

lsp.setup()
