local augroup = vim.api.nvim_create_augroup("curpos", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    group = augroup,
    pattern = "*",
    callback = function(opts)
        local ft = vim.bo[opts.buf].filetype
        local bufname = vim.api.nvim_buf_get_name(opts.buf)

        if ft == "commit" or ft == "rebase" or bufname:match("fugitive://") then
            return
        end

        local mark = vim.api.nvim_buf_get_mark(opts.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(opts.buf)

        if mark[1] > 1 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
