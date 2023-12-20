require("nvim-treesitter.configs").setup({
    -- ensure_installed = "maintained",
    sync_install = false,
    ignore_install = { "vala" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
        enable = false,
        enable_autocmd = false,
    },
})
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 9
local remember_fold_id = vim.api.nvim_create_augroup("remember_fold", {
    clear = true
})
vim.api.nvim_create_autocmd("BufWrite", {
    group = remember_fold_id,
    pattern = "?*",
    callback = function()
        if vim.bo.filetype == "markdown" or vim.bo.filetype == "NvimTree" or vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "TelescopeResults" then
            -- print("not used here")
            -- return
        else
            vim.cmd "silent! mkview"
        end
        return false
    end
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = remember_fold_id,
    pattern = "?*",
    callback = function()
        if vim.bo.filetype == "markdown" or vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "TelescopeResults" then
            -- print("not used here")
            -- return
        else
            vim.cmd "silent! loadview"
        end
        return false
    end
})
