-- https://neovim.io/doc/user/api.html#nvim_create_autocmd()
-- Remove whitespace when writing a bufer
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- Define a function to insert the current date using strftime
function Insert_formatted_date()
    local formatted_date = vim.fn.strftime("%Y-%m-%d") -- Change the format as needed
    vim.api.nvim_put({formatted_date}, '', true, true)
end

-- Create a key mapping to trigger the date insertion function (example: <Leader>d)
vim.api.nvim_set_keymap('n', '<Leader>d', [[:lua Insert_formatted_date()<CR>]], { noremap = true, silent = true })
