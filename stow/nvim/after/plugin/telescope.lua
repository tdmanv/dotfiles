local git = require('tdmanv.git')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "telescope file_files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "telescope live_grep" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "telescope grep_string" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "telescope buffers" })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = "telescope lsp_references" })
vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = "telescope git_status" })
vim.keymap.set('n', '<leader>fm', git.diff_master, { desc = "telescope tdmanv differ_masters" })
vim.keymap.set('n', '<leader>g', builtin.grep_string, { desc = "telescope grep_string" })

local trouble = require("trouble.sources.telescope")
local actions = require "telescope.actions"
require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key",

                -- Additions
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-t>"] = trouble.open,
            },
            n = {
                ["<C-t>"] = trouble.open,
            },
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        -- https://github.com/nvim-telescope/telescope.nvim/issues/394#issuecomment-966285634
        -- find_files = { find_command = { "rg", "--ignore", "-L", "--hidden", "--files" } }
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    },
    -- https://www.reddit.com/r/neovim/comments/nspg8o/telescope_find_files_not_showing_hidden_files/
    find_files = {
        -- hidden = true,
    }
}
