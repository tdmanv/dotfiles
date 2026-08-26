-- nvim-treesitter `main` branch API. The old `nvim-treesitter.configs` module
-- only exists on the frozen `master` branch.
-- Requires the tree-sitter CLI:  brew install tree-sitter-cli
local ts = require("nvim-treesitter")

ts.setup {
    -- Parsers and queries are installed here; setup() prepends it to runtimepath.
    install_dir = vim.fn.stdpath("data") .. "/site",
}

-- Neovim already bundles c, lua, markdown, query, vim and vimdoc parsers, but
-- installing them here keeps them in step with this plugin's queries.
local ensure_installed = {
    "bash",
    "c",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
    "yaml",
}

-- Asynchronous; a no-op for parsers that are already present.
ts.install(ensure_installed)

-- Replaces the old `auto_install = true`. Only languages nvim-treesitter knows
-- about can be fetched, and we only try once per language per session.
local available = nil
local attempted = {}

local function can_install(lang)
    if not available then
        available = {}
        for _, l in ipairs(ts.get_available()) do
            available[l] = true
        end
    end
    return available[lang] and not attempted[lang]
end

-- Replaces the old `highlight = { enable = true }`: on `main`, highlighting is
-- Neovim's (see :h treesitter-highlight) and has to be started per buffer.
vim.api.nvim_create_autocmd("FileType", {
    desc = "Start treesitter highlighting",
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
            return
        end

        -- Succeeds for anything already on runtimepath, including the parsers
        -- bundled with Neovim itself.
        if pcall(vim.treesitter.start, args.buf, lang) then
            return
        end

        if not can_install(lang) then
            return
        end
        attempted[lang] = true

        ts.install({ lang }):await(function()
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(args.buf) then
                    pcall(vim.treesitter.start, args.buf, lang)
                end
            end)
        end)
    end,
})
