local M = {}

function M.wk2_to_vanilla(keymaps, prefix, opts)
    for key, key_opt in next, keymaps do
        -- process group name if it is present
        if key_opt.name then
            if opts.buffer then
                vim.api.nvim_buf_set_keymap(opts.buffer, opts.mode, prefix .. key, "",
                    { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt.name })
            else
                vim.api.nvim_set_keymap(opts.mode, prefix .. key, "",
                    { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt.name })
            end

            -- do something with the rest kvs
            local sanitized_key_opt = vim.deepcopy(key_opt)
            sanitized_key_opt["name"] = nil
            M.wk2_to_vanilla(sanitized_key_opt, prefix .. tostring(key), opts)
        else
            -- the keybinding ends here
            if opts.buffer then
                vim.api.nvim_buf_set_keymap(opts.buffer, opts.mode, prefix .. key, key_opt[1],
                    { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt[2] })
            else
                vim.api.nvim_set_keymap(opts.mode, prefix .. key, key_opt[1],
                    { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt[2] })
            end
        end
    end
end

function M.del_wk2_to_vanilla(keymaps, prefix, opts)
    for key, key_opt in next, keymaps do
        -- process group name if it is present
        if key_opt.name then
            if opts.buffer then
                vim.api.nvim_buf_del_keymap(opts.buffer, opts.mode, prefix .. key) --, "",
               --     { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt.name })
            else
                vim.api.nvim_del_keymap(opts.mode, prefix .. key)--, "",
                    -- { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt.name })
            end

            -- do something with the rest kvs
            local sanitized_key_opt = vim.deepcopy(key_opt)
            sanitized_key_opt["name"] = nil
            M.del_wk2_to_vanilla(sanitized_key_opt, prefix .. tostring(key), opts)
        else
            -- the keybinding ends here
            if opts.buffer then
                vim.api.nvim_buf_del_keymap(opts.buffer, opts.mode, prefix .. key) --, key_opt[1],
                    -- { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt[2] })
            else
                vim.api.nvim_del_keymap(opts.mode, prefix .. key)--, key_opt[1],
                    -- { noremap = opts.noremap, nowait = opts.nowait, desc = key_opt[2] })
            end
        end
    end
end

return M
