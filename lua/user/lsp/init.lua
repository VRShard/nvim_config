local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

-- lsp on_attach will be invoked everytime a buffer is read/opened, so the keymaps are possibly registered multiple times
-- to make the situation worse, `which-key` plugin in which I have not found a proper workflow to remove a group of keybindings efficiently, has updated
-- to a new moajor version, and its key configs are much closer to vanilla neovim keybindings
-- TODO: for the current time, remove keybiding registration from using `which-key` plugin, and solely use vanilla neovim apis.
vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or not client.is_stopped then
            return
        end
        for k,_ in pairs(client.attached_buffers) do
            require("user.lsp.keymaps").unbind_default_lsp(k)
            vim.api.nvim_buf_set_keymap(k, "n", "<leader>" .. "l", "<cmd>LspStart<cr>", {noremap = true,nowait = true,desc = "load lsp"})
        end
        vim.schedule_wrap(require("notify"))("lsp detached: " .. (client and client.name or ""))
        -- vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
    -- Do something with the client
  end,
})
require "user.lsp.lspsaga_config"
require "user.lsp.lsp-installer"

require("user.lsp.handlers").setup()
--require "user.lsp.null-ls"

-- TODO: should setup whickkey keymaps here accordingly
