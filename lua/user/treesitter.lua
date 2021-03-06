local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end
configs.setup {
    -- ensure_installed = "maintained",
    sync_install = false,
    ignore_install = { "vala" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
local remember_fold_id = vim.api.nvim_create_augroup("remember_fold", {
    clear = true
})
vim.api.nvim_create_autocmd("BufWinLeave", {
    group = remember_fold_id,
    pattern = "?*",
    callback = function()
        if vim.bo.filetype == "NvimTree" or vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "TelescopeResults" then
            -- print("not used here")
            -- return
        else
            vim.cmd [[silent! mkview]]
        end
        return false
    end
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = remember_fold_id,
    pattern = "?*",
    callback = function()
        if vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "TelescopeResults" then
            -- print("not used here")
            -- return
        else
            vim.cmd [[silent! loadview]]
        end
        return false
    end
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    --command = "normal zx",
    callback = function()
        if vim.bo.buftype == "nofile" then
            -- print("not used here")
            -- return
        else
            vim.cmd [[normal zx]]
        end
        return false
    end
})
