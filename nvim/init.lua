-- Load custom environment configuration
local config = require("cconfig")

-- lazy.nvim Plugin Manager (https://github.com/folke/lazy.nvim)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {}

-- *==================*
-- | NON-LAZY PLUGINS |
-- *==================*

-- Welcome screen
table.insert(plugins, {
    'goolord/alpha-nvim',
    enabled = true,
    lazy = false,
    priority = 700,
    config = function()
        require('alpha').setup(require('dashboard').config)
    end
})

-- Indent colors
table.insert(plugins, {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    lazy = false,
    priority = 800,
    main = "ibl",
    config = function()
        require("ibl").setup()
        -- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
        -- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
        -- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
        -- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
        -- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
        -- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
        -- vim.cmd [[highlight IndentBlanklineIndent7 guifg=#E06C75 gui=nocombine]]
        -- vim.cmd [[highlight IndentBlanklineIndent8 guifg=#E5C07B gui=nocombine]]
        --
        -- vim.opt.list = true
        -- vim.opt.listchars:append "space:⋅"
        -- --vim.opt.listchars:append "eol:↴"
        --
        -- require("indent_blankline").setup {
        --     space_char_blankline = " ",
        --     show_current_context = true,
        --     show_current_context_start = true,
        --     char_highlight_list = {
        --         "IndentBlanklineIndent1",
        --         "IndentBlanklineIndent2",
        --         "IndentBlanklineIndent3",
        --         "IndentBlanklineIndent4",
        --         "IndentBlanklineIndent5",
        --         "IndentBlanklineIndent6",
        --         "IndentBlanklineIndent7",
        --         "IndentBlanklineIndent8",
        --     },
        -- }
    end
})

-- Transparent Background
table.insert(plugins, {
    'xiyaowong/nvim-transparent',
    enabled = true,
    lazy = false,
    priority = 900,
    build = ':TransparentEnable',
})

-- Color scheme
table.insert(plugins,
    {
        'folke/tokyonight.nvim',
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme tokyonight-night')
        end
    }
)

-- LSP
table.insert(plugins, {
    'neovim/nvim-lspconfig',
    enabled = true,
    lazy = false,
    dependencies = {
        'williamboman/nvim-lsp-installer',
        'Issafalcon/lsp-overloads.nvim'
    },
    config = function()
        -- Variable to support completition from LSP
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local custom_attach = function(client)
            -- Temporal until fix omnisharp
            if client.name == 'omnisharp' and vim.loop.os_uname().sysname ~= 'Darwin' then
                local function toSnakeCase(str)
                    return string.gsub(str, "%s*[- ]%s*", "_")
                end

                local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
                for i, v in ipairs(tokenModifiers) do
                    tokenModifiers[i] = toSnakeCase(v)
                end
                local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
                for i, v in ipairs(tokenTypes) do
                    tokenTypes[i] = toSnakeCase(v)
                end
            end

            --- Guard against servers without the signatureHelper capability
            if client.server_capabilities.signatureHelpProvider then
                require('lsp-overloads').setup(client, {})
            end
        end

        -- VIM
        require 'lspconfig'.vimls.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }

        -- LUA
        require 'lspconfig'.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false, -- To disable luassert prompt on start
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
            capabilities = capabilities,
            on_attach = custom_attach,
        }

        -- PYTHON
        require 'lspconfig'.pylsp.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }

        -- JavaScript
        require 'lspconfig'.tsserver.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }
        require 'lspconfig'.eslint.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }

        -- HTML
        require 'lspconfig'.html.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
            cmd = {
                "vscode-eslint-language-server", "--stdio"
            }
        }

        -- CSS, JS
        require 'lspconfig'.cssls.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }

        -- C++
        require 'lspconfig'.clangd.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }

        -- C#
        if vim.loop.os_uname().sysname == 'Linux' then
            require 'lspconfig'.omnisharp.setup {
                cmd = { "mono", "/home/bini/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp/OmniSharp.exe" },
                capabilities = capabilities,
                on_attach = custom_attach,
            }
        elseif vim.loop.os_uname().sysname == 'Darwin' then
            require 'lspconfig'.omnisharp.setup {
                cmd = { "/opt/homebrew/bin/mono", "/opt/homebrew/bin/omnisharp/OmniSharp.exe" },
                capabilities = capabilities,
                on_attach = custom_attach,
            }
        else
            require 'lspconfig'.omnisharp.setup {
                capabilities = capabilities,
                on_attach = custom_attach,
            }
        end

        -- YAML
        require 'lspconfig'.yamlls.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }
    end
})

table.insert(plugins, {
    'williamboman/mason.nvim',
    enabled = true,
    lazy = false,
    config = function()
        require("mason").setup()
    end,
    build = ':MasonUpdate'
})

table.insert(plugins, {
    'williamboman/mason-lspconfig.nvim',
    enabled = true,
    lazy = false,
    init = function()
        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls" },
        }
    end
})

table.insert(plugins, {
    'airblade/vim-gitgutter',
    enabled = true,
    lazy = false,
    config = function()
        vim.g.gitgutter_enabled = 1
        vim.g.gitgutter_map_keys = 0 -- Disables all keys

        local set = vim.opt

        set.signcolumn = "yes"
        set.updatetime = 100
    end
})

-- Completition
table.insert(plugins, {
    'hrsh7th/nvim-cmp',
    enabled = true,
    lazy = false,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/vim-vsnip',
        'hrsh7th/vim-vsnip-integ',
    },
    config = function()
        local cmp = require 'cmp'
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-a>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
            }, {
                { name = 'buffer' },
                { name = 'nvim_lsp_signature_help' }
            }, {
                { name = "neorg" },
            }),
            preselect = cmp.PreselectMode.None,
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end
})

-- Lualine
table.insert(plugins, {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    lazy = false,
    config = function()
        local function current_session()
            return ''
            --if require('auto-session-library') then
            --	return require('auto-session-library').current_session_name
            --end
        end

        local function overseer_line()
            local overseer = require 'overseer'

            return
            {
                "overseer",
                label = '',     -- Prefix for task counts
                colored = true, -- Color the task icons and counts
                symbols = {
                    [overseer.STATUS.FAILURE] = "F:",
                    [overseer.STATUS.CANCELED] = "C:",
                    [overseer.STATUS.SUCCESS] = "S:",
                    [overseer.STATUS.RUNNING] = "R:",
                },
                unique = false,     -- Unique-ify non-running task count by name
                name = nil,         -- List of task names to search for
                name_not = false,   -- When true, invert the name search
                status = nil,       -- List of task statuses to display
                status_not = false, -- When true, invert the status search
            }
        end

        local lualine = require 'lualine'
        lualine.setup({
            options = {
                theme = 'tokyonight'
            },
            sections = {
                lualine_c = { current_session() },
                lualine_x = {
                    require('nomodoro').status,
                },
            }
        })
    end
})

table.insert(plugins, {
    'romgrk/barbar.nvim',
    enabled = true,
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        insert_at_end = true,
        icons = {
            alternate = { button = 'X', filetype = { enabled = false } },
            current = { buffer_index = true, button = 'X' },
            inactive = { button = 'X' },
            visible = { button = 'X', modified = { buffer_number = false } },
        },
    }
})

-- Highlight
table.insert(plugins, {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    lazy = false,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context'
    },
    build = ':TSUpdate',
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "lua", "vim", "vimdoc", "c_sharp", "javascript", "html", "css", "python", "norg", "tsx",
                "markdown", "markdown_inline" },
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
})

-- *==============*
-- | LAZY PLUGINS |
-- *==============*

-- Comment lines
table.insert(plugins, {
    'numToStr/Comment.nvim',
    enabled = true,
    tag = 'v0.6.1',
    lazy = true,
    config = function()
        require('Comment').setup({
            mappings = {
                basic = false,
                extra = false,
                extended = false,
            },
        })
    end
})

-- Telescope
table.insert(plugins, {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    lazy = true,
    cmd = { "Telescope" },
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        -- 'nvim-telescope/telescope-dap.nvim',
        'GustavoKatel/telescope-asynctasks.nvim',
        'nvim-lua/plenary.nvim',
        'ahmedkhalf/project.nvim',
        'ThePrimeagen/harpoon',
        'crispgm/telescope-heading.nvim',
        'jemag/telescope-diff.nvim',
    },
    config = function()
        local actions = require("telescope.actions")

        local filter_file_extensions = {
            -- Unity
            ".meta",
            ".prefab",
            ".shader",
        }

        local find_files_commands = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
        for _, extension in ipairs(filter_file_extensions) do
            table.insert(find_files_commands, "-g")
            table.insert(find_files_commands, "!*" .. extension)
        end

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close
                    },
                },
                layout_config = {
                    vertical = { width = 0.9 }
                },
                file_ignore_patterns = { "^.git/" }
            },
            pickers = {
                find_files = {
                    find_command = find_files_commands,
                },
                colorscheme = {
                    enable_preview = true
                },
            },
            extensions = {
                heading = {
                    treesitter = true,
                    picker_opts = {
                        theme = "dropdown",
                        -- current_buffer_fuzzy_find = { sorting_strategy = 'ascending' },
                    },
                },
            },
        })

        require("telescope").load_extension "file_browser"
        require("telescope").load_extension "live_grep_args"
        require("telescope").load_extension('harpoon')
        require('telescope').load_extension('projects')
        require('telescope').load_extension('asynctasks')
        require('telescope').load_extension('heading')
        require("telescope").load_extension("diff")
        -- require('telescope').load_extension('dap')
    end
})

-- Key Mapping viewer
table.insert(plugins, {
    'folke/which-key.nvim',
    enabled = true,
    lazy = true,
    config = function()
        require("which-key").setup {
            preset = 'helix',
            win = {
                border = "double",
                padding = { 2, 3, 2, 3 }
            },
            delay = 300,
            sort = { "manual" },
        }
    end
})

table.insert(plugins, {
    'Pocco81/auto-save.nvim',
    enabled = true,
    lazy = true,
    event = {
        'InsertLeave',
        'TextChanged',
    },
    config = function()
        require("auto-save").setup({
            enabled = true,
            execution_message = {
                message = function() -- message to print on save
                    return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                end
            },
            trigger_events = { "InsertLeave", "TextChanged" },
        })
    end
})

table.insert(plugins, {
    'dbinagi/nomodoro',
    enabled = true,
    lazy = true,
    config = function()
        require('nomodoro').setup({
            on_break_complete = function()
                require("notify")("Break complete!")
            end,
            on_work_complete = function()
                require("notify")("Work complete!")
            end
        })
    end
})

table.insert(plugins, { 'rcarriga/nvim-notify', enabled = true, lazy = true })

table.insert(plugins, { 'Pocco81/true-zen.nvim', enabled = true, lazy = true })

table.insert(plugins, { 'MunifTanjim/nui.nvim', enabled = true, lazy = true })

-- table.insert(plugins, {
--     'mfussenegger/nvim-dap',
--     enabled = true,
--     lazy = true,
--     config = function()
--         local dap = require("dap")
--         dap.adapters.gdb = {
--             type = "executable",
--             command = "gdb",
--             args = { "-i", "dap" }
--         }
--
--         -- local dap = require("dap")
--         dap.configurations.c = {
--             {
--                 name = "Launch",
--                 type = "gdb",
--                 request = "launch",
--                 program = function()
--                     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--                 end,
--                 cwd = "${workspaceFolder}",
--             },
--         }
--     end
-- })

table.insert(plugins, {
    'CosmicNvim/cosmic-ui',
    enabled = true,
    lazy = true,
    config = function()
        require('cosmic-ui').setup()
    end
})

table.insert(plugins, {
    'rmagatti/goto-preview',
    enabled = true,
    lazy = true,
    config = function()
        local telescope_themes = require('telescope.themes')

        require('goto-preview').setup {
            width = 120,                                         -- Width of the floating window
            height = 15,                                         -- Height of the floating window
            border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
            default_mappings = false,                            -- Bind default mappings
            debug = false,                                       -- Print debug information
            opacity = nil,                                       -- 0-100 opacity level of the floating window where 100 is fully transparent.
            resizing_mappings = false,                           -- Binds arrow keys to resizing the floating window.
            post_open_hook = nil,                                -- A function taking two arguments, a buffer and a window to be ran as a hook.
            references = {                                       -- Configure the telescope UI for slowing the references cycling window.
                telescope = telescope_themes.get_dropdown({ hide_preview = false })
            },
            -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
            focus_on_open = true,    -- Focus the floating window when opening it.
            dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
            force_close = true,      -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
            bufhidden = "wipe",      -- the bufhidden option to set on the floating window. See :h bufhidden
        }
    end
})

table.insert(plugins, {
    'f-person/git-blame.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'GitBlameToggle' },
    config = function()
        vim.g.gitblame_enabled = " "
    end
})

table.insert(plugins, {
    'skywind3000/asynctasks.vim',
    enabled = true,
    lazy = true,
    dependencies = {
        'skywind3000/asyncrun.vim'
    },
    cmd = { 'AsyncTask', 'AsyncTaskEdit', 'Telescope' },
    config = function()
        vim.g.asyncrun_open = 6
        vim.g.asynctasks_term_pos = 'tab'
    end
})

table.insert(plugins, {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    enabled = true,
    cmd = { "ObsidianSearch", "ObsidianQuickSwitch", "ObsidianNew", "ObsidianTags", "ObsidianToggleCheckbox" },
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = config.NOTES_FOLDER,
                strict = true,
            },
        },
        daily_notes = {
            folder = "dailies",
        },
        follow_url_func = function(url)
            if vim.loop.os_uname().sysname == 'Linux' then
                os.execute('wslview ' .. url .. " > /dev/null 2>&1")
            else
                vim.fn.jobstart({ "open", url }) -- Mac OS
            end
        end,
        ui = {
            enable = false
        }
    },
})

-- table.insert(plugins, {
--     "AntonVanAssche/md-headers.nvim",
--     enabled = true,
--     lazy = false,
--     version = '*',
--     dependencies = {
--         'nvim-lua/plenary.nvim',
--         'nvim-treesitter/nvim-treesitter',
--     },
--     config = function()
--         require('md-headers').setup { height = 30, width = 200 }
--     end,
-- })
--
-- vim.api.nvim_set_hl(0, "MarkdownHeadersTitle", { fg = "#cfc9c2" })
-- vim.api.nvim_set_hl(0, "MarkdownHeadersWindow", { fg = "#cfc9c2" })
-- vim.api.nvim_set_hl(0, "MarkdownHeadersBorder", { fg = "#cfc9c2" })
--
-- table.insert(plugins, { 'Scuilion/markdown-drawer', enabled = true, lazy = false })

-- Testing plugins
-- Plug 'stevearc/overseer.nvim'
-- Plug 'rmagatti/auto-session'
-- Plug 'tpope/vim-fugitive'
-- Plug 'j-hui/fidget.nvim'

-- table.insert(plugins, {
--     "nvim-neorg/neorg",
--     build = ":Neorg sync-parsers",
--     lazy = false, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
--     -- tag = "*",
--     dependencies = { "nvim-lua/plenary.nvim" },
--     config = function()
--         require("neorg").setup {
--             load = {
--                 ["core.defaults"] = {}, -- Loads default behaviour
--                 ["core.concealer"] = {}, -- Adds pretty icons to your documents
--                 ["core.dirman"] = { -- Manages Neorg workspaces
--                     config = {
--                         workspaces = {
--                             notes = "~/notes",
--                         },
--                     },
--                 },
--                 ["core.completion"] = { -- A wrapper to interface with several different completion engines.
--                     config = {
--                         engine = "nvim-cmp"
--                     },
--                 },
--                 ["core.export.markdown"] = {},
--                 ["core.esupports.hop"] = {},
--                 ["core.export"] = {
--                     config = {
--                         export_dir = "~/notes_export_dir"
--                     }
--                 },
--                 ["core.keybinds"] = {
--                     config = {
--                         default_keybinds = false,
--                     }
--                 },
--                 ["core.qol.toc"] = {
--                     config = {
--                         close_after_use = true,
--                     }
--                 },
--             },
--         }
--     end,
-- })

table.insert(plugins, {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})

table.insert(plugins, {
    "karb94/neoscroll.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        require('neoscroll').setup({
        })
    end
})

table.insert(plugins, {
    "mfussenegger/nvim-lint",
    version = "*",
    enabled = false,
    event = "VeryLazy",
    config = function()
        require('lint').linters_by_ft = {
            lua = { 'luacheck', }
        }
    end
})

table.insert(plugins, {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("markview").setup({
            list_items = {
                enable = false,
            }
        });
    end
})

table.insert(plugins, {
    'ibhagwan/smartyank.nvim',
    enabled = true,
    lazy = false,
    config = function()
        require('smartyank').setup {highlight = {timeout=200}}
    end,
})

-- *===================*
-- | LUA configuration |
-- *===================*

-- Set leader key before configurations
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- LOAD PLUGINS
require("lazy").setup(plugins, {
    install = {
        colorscheme = { "tokyonight-night" }
    }
})

require('ckeys')
require('cnotes')
require('cmarkdown')

-- *=======================*
-- | GENERAL CONFIGURATION |
-- *=======================*

vim.o.number         = true          -- Show line number
vim.o.relativenumber = true          -- Show relative from cursor to other lines
vim.o.showmatch      = true          -- Show matching
vim.o.hlsearch       = true          -- Highlight search
vim.o.clipboard      = "unnamedplus" -- Copy and Paste from system clipboard
vim.o.tabstop        = 4             -- Columns occupied by tab
vim.o.softtabstop    = 4             -- Multiple spaces as tab
vim.o.shiftwidth     = 4             -- Width for autoindents
vim.o.expandtab      = true          -- Converts tab to spaces
vim.o.autoindent     = true          -- Indent a new lines the same as before
vim.o.mouse          = "a"           -- Enable mouse click
vim.o.cursorline     = true          -- Highlight current cursorline
vim.o.splitright     = true
vim.o.completeopt    = "menu,menuone,noselect"
vim.o.showcmd        = true
vim.o.timeoutlen     = 200      -- Reduce timeout for leader (default 1000ms)
vim.o.termguicolors  = true
vim.o.ignorecase     = true     -- Ignore case when searching
vim.o.smartcase      = true     -- Switch search to case sensitive when upperletter
vim.o.foldmethod     = "syntax" -- Fold based on syntax
-- vim.o.foldmethod        = "indent"                      -- Fold based on indention levels
-- vim.o.foldnestmax       = 3                             -- Fold up to 3 nested levels

vim.cmd("noswapfile") -- Disable creating swap file
vim.cmd("set cc=80")
vim.cmd("set autoread")
vim.cmd("set ffs=unix,dos")
vim.cmd("set nofoldenable")
vim.cmd("syntax enable")

-- *===================*
-- | LANGUAGE SPECIFIC |
-- *===================*

-- LUA
------

-- vim.cmd('au BufWritePost * lua require("lint").try_lint()')


-- C#
-----

-- Turn manually syntax on on .cs files and include region folding
-- vim.cmd('au BufRead,BufNewFile *.cs syntax on')
-- vim.cmd('au BufRead,BufNewFile *.cs syn region csregion start=/#region/ end=/#endregion/ transparent fold')
-- vim.cmd('au BufRead,BufNewFile *.cs normal zR')

-- MAKE
-------

-- Enable tabs on makefiles
vim.cmd('au BufRead,BufNewFile FileType make set noexpandtab')

-- NOTE TAKING
--------------

-- Show links with name on norg files
-- vim.cmd('autocmd FileType norg setlocal conceallevel=1')

vim.cmd('autocmd FileType markdown setlocal conceallevel=2')
vim.cmd('autocmd FileType markdown setlocal foldmethod=expr')
vim.cmd('autocmd FileType markdown setlocal foldexpr=nvim_treesitter#foldexpr()')
vim.cmd('autocmd FileType markdown setlocal foldlevel=8')
