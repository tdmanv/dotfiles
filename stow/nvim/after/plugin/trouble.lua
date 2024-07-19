-- https://github.com/folke/trouble.nvim
vim.keymap.set("n", "<leader>t", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "gr", function() require("trouble").open("lsp_references") end)
