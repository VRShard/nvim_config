local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
    return
end

impatient.enable_profile()
require("user.option")
require("user.packer")
require("user.telescope")
require("user.treesitter")
require("user.cmp")
require("user.keymaps")
require("user.colorscheme")
require("user.auto_color")
require("user.lsp")
require("user.lualine_config")
require("user.nvim_tree_config")
require("user.autopairs")
require("user.autocomment")
require("user.indention")
require("user.bufferline")
require("user.whichkey")
require("user.toggleterm")
