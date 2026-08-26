-- you can add this in your init.lua
-- (note: diagnostics are not exclusive to LSP)

-- Show diagnostics in a floating window
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- Move to the previous diagnostic
-- (goto_prev/goto_next are deprecated since 0.11 in favour of jump())
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)

-- Move to the next diagnostic
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = event.buf }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- You can find details of these function in the help page
        -- see for example, :help vim.lsp.buf.hover()

        -- Trigger code completion
        bufmap('i', '<C-Space>', '<C-x><C-o>')

        -- Display documentation of the symbol under the cursor
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

        -- Jump to declaration
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

        -- Lists all the implementations for the symbol under the cursor.
        -- lsp-zero used to override this with the telescope picker; keep that.
        bufmap('n', 'gi', function()
            require('telescope.builtin').lsp_implementations({ reuse_win = true })
        end)

        -- Jumps to the definition of the type symbol
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

        -- Lists all the references
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

        -- Displays a function's signature information
        bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

        -- Renames all references to the symbol under the cursor
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Format current file
        bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format()<cr>')

        -- Selects a code action available at the current cursor position
        bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    end
})
