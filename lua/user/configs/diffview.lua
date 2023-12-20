require("diffview").setup({
    view = {
        default = {
            winbar_info = true,
        },
        file_history = {
            winbar_info = true
        }
    }
})
vim.api.nvim_create_user_command("DiffviewToggle", function(e)
    local view = require("diffview.lib").get_current_view()

    if view then
        vim.cmd("DiffviewClose")
    else
        vim.cmd("DiffviewOpen " .. e.args)
    end
end, { nargs = "*" }
)
