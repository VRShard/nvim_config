local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup({
    options = {
        buffer_close_icon = '',
        style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        themable = true,
        separator_style = "thick",
        enforce_regular_tabs = true,
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'underline',
        },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            }
        },
    }
});
vim.api.nvim_set_keymap("n", "gB", "<cmd>BufferLinePick<CR>", { noremap = true, silent = true })
