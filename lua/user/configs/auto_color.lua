local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
    update_interval = 1000,
    set_dark_mode = function()
        -- vim.api.nvim_set_option('background', 'dark')
        vim.g.material_style = 'darker'
        vim.cmd('colorscheme material')
    end,
    set_light_mode = function()
        -- vim.api.nvim_set_option('background', 'light')
        vim.g.material_style = 'lighter'
        vim.cmd('colorscheme material')
    end,
})
auto_dark_mode.init()
