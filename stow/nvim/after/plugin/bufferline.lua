vim.opt.termguicolors = true

require("bufferline").setup{}

vim.keymap.set("n", "gt", vim.cmd.BufferLineCycleNext)
vim.keymap.set("n", "gT", vim.cmd.BufferLineCyclePrev)

vim.keymap.set("n", "<right>", vim.cmd.BufferLineCycleNext)
vim.keymap.set("n", "<left>", vim.cmd.BufferLineCyclePrev)

vim.keymap.set("n", "<leader>q", vim.cmd.bdelet)
