return {
    "nvim-treesitter/nvim-treesitter",
    -- The `main` branch is a full rewrite of the plugin. It does not support
    -- lazy-loading, and parsers must be kept in lockstep with the plugin
    -- itself, hence the build step.
    lazy = false,
    build = ":TSUpdate",
}
