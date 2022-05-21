local local_opt = {
    cmd = { "lua-language-server", "--preview" },
    settings = {

        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
}
local M={}
M.setup = function(lspconfig, opts)
    local_opt = vim.tbl_deep_extend("force", local_opt, opts)
    lspconfig.sumneko_lua.setup(local_opt)
end
return M
