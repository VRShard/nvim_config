local local_opt = {
    settings = {
        ["rust-analyzer"] = {
            cachePriming = {
                enable = true,
                numThreads = 0,
            },
            cargo = {
                features = "all",
                autoreload = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                    enable = true,
                }
            },
            checkOnSave = {
                enable = true
            },
            completion = {
                autoself = {
                    enable = true,
                },
                autoimport = {
                    enable = true,
                },
            },
            experimental = {
                procAttrMacros = true
            },
            hover = {
                actions = {
                    enable = true,
                    debug = {
                        enable = true,
                    },
                    gotoTypeDef = {
                        enable = true,
                    },
                    implementations = {
                        enable = true,
                    },
                    references = {
                        enable = false,
                    },
                    documentation = {
                        enable = true,
                    },
                    run = {
                        enable = true,
                    },
                }
            },
            inlayHints = {
                enable = true,
                parameterHints = { enable = true },
                typeHints = { enable = true },
                chainingHints = { enable = true },
                lifetimeElisionHints = {
                    enable = "always"
                }
            },
            lens = {
                enable = true,
                forceCustomCommands = true,
                implementations = { enable = true },
                references = {
                    enable = true,
                    adt = { enable = true },
                    enumVariant = { enable = true },
                    method = { enable = true },
                    trait = { enable = true },
                },
                run = { enable = true },
            },
            procMacro = {
                enable = true,
                attributes = {
                    enable = true
                }
            },
            -- highlightRelated = {
            --     references = true,
            --     exitPoints = true,
            --     breakPoints = true,
            --     yieldPoints = true
            -- }
        },

    }
}
-- vim.env.PATH = "$HOME/.local/share/nvim/lsp_servers/rust:" .. vim.env.PATH
local M = {}
M.setup = function(_, opts)
    --todo
    local_opt = vim.tbl_deep_extend("force", local_opt, opts)
    local final_opts = {
        tools = {
            autoSetHints = true,
            inlay_hints = {
                -- wheter to show parameter hints with the inlay hints or not
                show_parameter_hints = true,
                -- prefix for parameter hints
                parameter_hints_prefix = "<- ",
                show_variable_name = true,
                -- prefix for all the other hints (type, chaining)
                other_hints_prefix = "=> ",
                highlight = "Comment",
            },
        },
        server = local_opt
    }
    require 'rust-tools'.setup(final_opts)
end
return M
