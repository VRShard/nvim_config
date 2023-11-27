local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/lazy/lazy.nvim"
-- if fn.empty(fn.glob(install_path)) > 0 then
if not vim.loop.fs_stat(install_path) then
    LAZY_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=main", -- latest stable release
        install_path,
    }
    print "Installing Lazy close and reopen Neovim..."
    --[[ vim.cmd "packadd packer.nvim" ]]
end
vim.opt.rtp:prepend(install_path)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--     augroup packer_user_config
--         autocmd!
--         autocmd BufWritePost package_loader.lua Lazy sync
--     augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, package_manager = pcall(require, "lazy")
if not status_ok then
    return
end

-- Install your plugins here
local plugins_map = {
    -- My plugins here
    {
        "folke/lazy.nvim" -- Have packer manage itself
    },
    {
        "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    },
    {
        "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    },
    -- {
    --     'lewis6991/impatient.nvim'
    -- },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end
    },
    {
        'simnalamburt/vim-mundo'
    },
    {
        "windwp/nvim-autopairs"
    },
    {
        "tpope/vim-surround"
    },
    {
        "tpope/vim-repeat"
    },
    {
        "numToStr/Comment.nvim"
    },
    {
        'akinsho/bufferline.nvim',
        branch = "main",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        "moll/vim-bbye"
    },
    {
        "mfussenegger/nvim-dap"
    },
    {
        "rcarriga/nvim-dap-ui"
    },
    {
        'antoinemadec/FixCursorHold.nvim'
    },
    {
        'rmagatti/auto-session',
        lazy = false
    },
    {
        'rmagatti/session-lens',
        dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        config = function()
            require('session-lens').setup({})
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    --[[ { ]]
    --[[     "narutoxy/silicon.lua", ]]
    --[[     dependencies = { "nvim-lua/plenary.nvim" }, ]]
    --[[     config = function() ]]
    --[[         require('silicon').setup({ ]]
    --[[             font = "IBM Plex Mono", ]]
    --[[             debug = true, ]]
    --[[             theme = "material", ]]
    --[[             lineNumber = false, ]]
    --[[         }) ]]
    --[[     end ]]
    --[[ }, ]]

    { "sainnhe/everforest" },
    {
        'marko-cerovac/material.nvim'
    },
    {
        'Luxed/ayu-vim'
    },

    -- use "ggandor/lightspeed.nvim"
    {
        "ggandor/leap.nvim",
        config = function() require("leap").set_default_keymaps() end
    },

    -- LSP
    {
        "neovim/nvim-lspconfig" -- enable LSP
    },
    --use 'nvim-lua/lsp_extensions.nvim'
    { 'simrat39/rust-tools.nvim',        branch = "master" },
    --[[ use "williamboman/nvim-lsp-installer" -- simple to use language server installer ]]
    {
        "williamboman/mason.nvim", -- simple to use language server installer
        config = function ()
            require("mason").setup({
                ui = {
                    border = "single",
                }
            })
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end
    },
    -- use "jose-elias-alvarez/null-ls.nvim"
    --[[ use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", ]]
    --[[     config = function() ]]
    --[[         require("lsp_lines").setup() ]]
    --[[     end, ]]
    --[[ }) ]]
    -- cmp
    {
        'hrsh7th/cmp-nvim-lsp'
    },
    {
        'hrsh7th/cmp-buffer'
    },
    {
        'hrsh7th/cmp-path'
    },
    {
        'hrsh7th/cmp-cmdline'
    },
    {
        'hrsh7th/nvim-cmp'
    },
    {
        "folke/neodev.nvim"
    },

    -- snip
    --use 'hrsh7th/cmp-vsnip'
    --use 'hrsh7th/vim-vsnip'
    {
        "saadparwaiz1/cmp_luasnip" -- snippet completions
    },
    {
        "L3MON4D3/LuaSnip" --snippet engine
    },
    {
        "rafamadriz/friendly-snippets" -- a bunch of snippets to use
    },
    {
        'hrsh7th/cmp-nvim-lua'
    },

    --use { "nvim-telescope/telescope-file-browser.nvim" }
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            local _devicons = require 'nvim-web-devicons'
            if _devicons.has_loaded() then
                _devicons.set_icon {
                    scm = {
                        icon = "ƛ",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Scheme"
                    }
                }
            else
                _devicons.setup {
                    override = {
                        scm = {
                            icon = "ƛ",
                            color = "#428850",
                            cterm_color = "65",
                            name = "Scheme"
                        }
                    },
                }
            end
        end
    },
    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" }, -- Tree-sitter
    --[[ use { 'nvim-treesitter/nvim-treesitter-context' } -- Tree-sitter ]]
    {
        -- "HiPhish/nvim-ts-rainbow2"
        "HiPhish/rainbow-delimiters.nvim"
    },
    {
        'nvim-treesitter/playground'
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
            enable_autocmd = false,
        }
    },

    -- {
    --     "lukas-reineke/indent-blankline.nvim"
    -- },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    {
        "nvim-lua/lsp-status.nvim"
    },
    --use "arkav/lualine-lsp-progress"
    {
        "glepnir/lspsaga.nvim",
        --[[ branch = "ref", ]]
    },
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icon
        },
    },

    {
        "akinsho/toggleterm.nvim",
        branch = "main"
    },
    {
        "folke/which-key.nvim"
    },

    {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true,            -- shift content if tab out is not possible
                act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                enable_backwards = true,      -- well ...
                completion = true,            -- if the tabkey is used in a completion pum
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' },
                    { open = '<', close = '>' },
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        wants = { 'nvim-treesitter' }, -- or require if not used so far
        after = { 'cmp-nvim-lua' }     -- if a completion plugin is using tabs load it before
    },

    {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
        lazy = false,
    },
    {
        'sindrets/diffview.nvim',
        config = function ()
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
        end
    },
    --[[ use { 'simrat39/symbols-outline.nvim', ]]
    --[[     config = function() require("symbols-outline").setup() end ]]
    --[[ } ]]

    {
        "f-person/auto-dark-mode.nvim"
    },
    --[[ { ]]
    --[[     "dstein64/vim-startuptime" ]]
    --[[ } ]]
}
package_manager.setup({
    spec = {
        plugins_map,
        { import = "plugins" },
    },
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    defaults = {
        lazy = false,                         -- should plugins be lazy-loaded?
        version = nil,
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    -- leave nil when passing the spec as the first argument to setup()
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
    git = {
        -- defaults for the `Lazy log` command
        -- log = { "-10" }, -- show the last 10 commits
        log = { "--since=3 days ago" }, -- show commits from the last 3 days
        timeout = 120,                  -- kill processes that take more than 2 minutes
        url_format = "https://github.com/%s.git",
        -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
        -- then set the below to false. This is should work, but is NOT supported and will
        -- increase downloads a lot.
        filter = true,
    },
    -- dev = {
    --     -- directory where you store your local plugin projects
    --     path = "~/projects",
    --     ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    --     patterns = {},    -- For example {"folke"}
    --     fallback = false, -- Fallback to git when local plugin doesn't exist
    -- },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "material" },
    },
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.8, height = 0.8 },
        wrap = true, -- wrap the lines in the ui
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",
        icons = {
            cmd = " ",
            config = "",
            event = "",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "鈴 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            source = " ",
            start = "",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
        -- leave nil, to automatically select a browser depending on your OS.
        -- If you want to use a specific browser, you can define it here
        browser = nil, ---@type string?
        throttle = 20, -- how frequently should the ui process render events
        custom_keys = {
            -- you can define custom key maps here.
            -- To disable one of the defaults, set it to false

            -- open lazygit log
            ["<localleader>l"] = function(plugin)
                require("lazy.util").float_term({ "lazygit", "log" }, {
                    cwd = plugin.dir,
                })
            end,
            -- open a terminal for the plugin dir
            ["<localleader>t"] = function(plugin)
                require("lazy.util").float_term(nil, {
                    cwd = plugin.dir,
                })
            end,
        },
    },
    diff = {
        -- diff command <d> can be one of:
        -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
        --   so you can have a different command for diff <d>
        -- * git: will run git diff and open a buffer with filetype git
        -- * terminal_git: will open a pseudo terminal with git diff
        -- * diffview.nvim: will open Diffview to show the diff
        cmd = "git",
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true,    -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = true, -- get a notification when changes are found
    },
    performance = {
        cache = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/lazy/cache",
            -- Once one of the following events triggers, caching will be disabled.
            -- To cache all modules, set this to `{}`, but that is not recommended.
            -- The default is to disable on:
            --  * VimEnter: not useful to cache anything else beyond startup
            --  * BufReadPre: this will be triggered early when opening a file from the command line directly
            disable_events = { "UIEnter", "BufReadPre" },
            ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
        },
        reset_packpath = true,   -- reset the package path to improve startup time
        rtp = {
            reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {},          -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                -- "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                -- "tarPlugin",
                -- "tohtml",
                -- "tutor",
                -- "zipPlugin",
            },
        },
    },
    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    readme = {
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        -- only generate markdown helptags for plugins that dont have docs
        skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
})
-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
-- if LAZY_BOOTSTRAP then
--     require("user.packer").sync()
-- end
