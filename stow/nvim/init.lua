vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.lazy")

require("tdmanv.git")
require("tdmanv.remap")
require("tdmanv.set")
require("tdmanv.api")
require("tdmanv.lsp")

vim.cmd [[colorscheme tokyonight-moon]]
