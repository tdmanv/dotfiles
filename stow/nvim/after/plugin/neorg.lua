vim.keymap.set("n", "<leader>n", ":Neorg index<CR>:Neorg toc<CR>")

require("neorg").setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    kasten = "~/Dropbox/kasten/notes",
                },
                default_workspace = "kasten"
            },
        },
    },
}

