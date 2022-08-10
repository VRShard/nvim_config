local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end
lsp_installer.setup {}

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local lspconfig = require("lspconfig")
local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
}
opts.capabilities = vim.tbl_extend('keep', opts.capabilities or {}, lsp_status.capabilities)

require("user.lsp.settings.sumneko_lua").setup(lspconfig, opts)

require("user.lsp.settings.rust_analyzer").setup(lspconfig, opts)

lspconfig.svelte.setup(opts)

lspconfig.tsserver.setup(opts)

lspconfig.gopls.setup(opts)

lspconfig.pyright.setup(opts)

lspconfig.taplo.setup(opts)

lspconfig.omnisharp.setup(vim.tbl_deep_extend(
    "force",
    {
        use_mono = true;
    },
    opts
))
