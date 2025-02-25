-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options
require("conform").setup({
    log_level = vim.log.levels.DEBUG,
    -- Map of filetype to formatters
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        -- go = { "goimports", "gofmt", "golines" },
        go = { "goimports", "gofmt" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = "fallback",
        timeout_ms = 1000,
    },
})
