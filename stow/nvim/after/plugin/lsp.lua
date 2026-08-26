-- Native LSP setup (Neovim 0.11+). This replaces lsp-zero, which is
-- unmaintained and drove the deprecated `require('lspconfig')` framework.
-- Keymaps live in lua/tdmanv/lsp.lua, on an LspAttach autocmd.

-- Advertise nvim-cmp's completion capabilities to every server.
-- `*` is merged into each config; see :h vim.lsp.config().
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gopls
vim.lsp.config('gopls', {
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

-- Teach lua_ls about the Neovim runtime, which is what lsp-zero's
-- `nvim_lua_ls()` used to do.
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
            },
        })
    end,
    settings = {
        Lua = {},
    },
})

-- mason must be set up before mason-lspconfig.
-- https://github.com/mason-org/mason-lspconfig.nvim#quickstart
require('mason').setup()
require('mason-lspconfig').setup {
    -- ensure_installed = { "lua_ls", "gopls", "bashls" },
    ensure_installed = { 'lua_ls', 'gopls' },
    -- Servers installed through mason are passed to vim.lsp.enable() for us.
    automatic_enable = true,
}

-- Servers installed outside of mason still need enabling by hand, e.g.:
--   npm i -g bash-language-server
-- vim.lsp.enable('bashls')

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    -- No `luasnip` source here: that needs saadparwaiz1/cmp_luasnip, which
    -- isn't installed. LuaSnip is only used to expand LSP-provided snippets.
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }),
    mapping = cmp.mapping.preset.insert({
        -- Require an explicit selection rather than confirming the first item.
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
})
