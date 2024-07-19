local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values


local git = {}

git.diff_master = function(opts)
  opts = opts or {}
  -- Requires a git alias for:
  -- git diff --name-only --relative $(git merge-base HEAD master)
  local git_command = { "git", "d" }
  vim.print(git_command)
  pickers
    .new(opts, {
      prompt_title = "Git Diff Master",
      finder = finders.new_oneshot_job(
        vim.tbl_flatten { git_command, },
        opts
      ),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
    })
    :find()
end

return git
