local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
    return
end
local user_home = os.getenv('HOME')
lsp_installer.setup()

local lsp_status = require("lsp-status")
lsp_status.config({
    diagnostics = false,
})
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

lspconfig.wgsl_analyzer.setup(opts)

lspconfig.zls.setup(opts)

lspconfig.clangd.setup(vim.tbl_deep_extend(
    "force",
    {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
    },
    opts
))

lspconfig.omnisharp.setup(vim.tbl_deep_extend(
    "force",
    {
        use_mono = true,
        cmd = { user_home .. "/.local/share/nvim/mason/packages/omnisharp-mono/run" },
        ["csharp"] = {
            inlayHints = {
                parameters = {
                    enabled = true,
                },
                types = {
                    enabled = true,
                },
            }
        }
    },
    opts
))
