require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
})

local local_opt = {
    cmd = { "lua-language-server", "--preview" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace   = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
                checkThirdParty = false,
            },
            hint        = {
                enable = true,
            },
            runtime     = {
                special = {
                    --[[ ["require"] = "require", ]]
                },
            },
            completion  = {
                callSnippet = "Replace"
            },
        },
    },
}
local M = {}
M.setup = function(lspconfig, opts)
    local_opt = vim.tbl_deep_extend("force", local_opt, opts)
    lspconfig.lua_ls.setup(local_opt)
end
return M
