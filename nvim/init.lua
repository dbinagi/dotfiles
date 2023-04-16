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

-- *=========*
-- | PLUGINS |
-- *=========*

local plugins = {}

-- Welcome screen
table.insert(plugins, {
    'goolord/alpha-nvim',
    lazy = false,
    priority = 700,
    config = function()
        require('alpha').setup(require('dashboard').config)
    end
})

table.insert(plugins, {
    'lukas-reineke/indent-blankline.nvim',
    lazy = false,
    priority = 800,
    config = function()
        vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent7 guifg=#E06C75 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent8 guifg=#E5C07B gui=nocombine]]

        vim.opt.list = true
        vim.opt.listchars:append "space:⋅"
        --vim.opt.listchars:append "eol:↴"

        require("indent_blankline").setup {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
            char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
                "IndentBlanklineIndent7",
                "IndentBlanklineIndent8",
            },
        }
    end
})

table.insert(plugins, {
    'xiyaowong/nvim-transparent',
    lazy = false,
    priority = 900,
    config = function()
        require("transparent").setup({})
        vim.api.nvim_command(':TransparentEnable')
    end
})

-- Color scheme
table.insert(plugins,
    {
        'folke/tokyonight.nvim',
        branch = 'main',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme tokyonight-night')
        end
    }
)

table.insert(plugins, { 'williamboman/nvim-lsp-installer' })

table.insert(plugins, {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
        -- Installer must go before LSP config
        require("nvim-lsp-installer").setup {}

        -- Variable to support completition from LSP
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true


        local custom_attach = function(client)
            -- Temporal until fix omnisharp
            if client.name == 'omnisharp' then
                client.server_capabilities.semanticTokensProvider.legend = {
                    tokenModifiers = { "static" },
                    tokenTypes = { "comment", "excluded", "identifier", "keyword", "keyword", "number", "operator",
                        "operator", "preprocessor", "string", "whitespace", "text", "static", "preprocessor",
                        "punctuation", "string", "string", "class", "delegate", "enum", "interface", "module", "struct",
                        "typeParameter", "field", "enumMember", "constant", "local", "parameter", "method", "method",
                        "property", "event", "namespace", "label", "xml", "xml", "xml", "xml", "xml", "xml", "xml",
                        "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml",
                        "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp" }
                }
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
                        checkThirdParty = false,
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

        -- JavaScript
        require 'lspconfig'.tsserver.setup {
            capabilities = capabilities,
            on_attach = custom_attach,
        }

        require 'lspconfig'.ccls.setup {
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
        require 'lspconfig'.ccls.setup {
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
        else
            require 'lspconfig'.omnisharp.setup {
                capabilities = capabilities,
            }
        end
    end
})

table.insert(plugins, {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
        require("mason").setup()
    end
})

table.insert(plugins, {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    init = function()
        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls" },
        }
    end
})

-- Icons
table.insert(plugins, {'nvim-tree/nvim-web-devicons', lazy = true})

-- Comment lines
table.insert(plugins, {
    'numToStr/Comment.nvim',
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

-- Completition

table.insert(plugins, {
    'hrsh7th/nvim-cmp',
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
            -- window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            -- },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
            }, {
                { name = 'buffer' },
                { name = 'nvim_lsp_signature_help' }
            })
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

-- Telescope
table.insert(plugins, { 'nvim-lua/plenary.nvim' })
table.insert(plugins, {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
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
            }
        })

        require("telescope").load_extension "file_browser"
        require("telescope").load_extension "live_grep_args"
        require("telescope").load_extension('harpoon')
    end
})

table.insert(plugins, {
    'folke/which-key.nvim',
    lazy = true,
    config = function()
        require("which-key").setup {
            window = {
                border = "double",
                padding = { 2, 3, 2, 3 }
            },
            triggers = { "<leader>" },
        }
    end
})

-- Highlight
table.insert(plugins, {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require 'nvim-treesitter.configs'.setup {
            -- A list of parser names, or "all"
            ensure_installed = { "lua", "vim", "c_sharp", "javascript", "html", "css", "python" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- List of parsers to ignore installing (for "all")
            -- ignore_install = { "javascript" },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,
                -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                -- the name of the parser)
                -- list of language that will be disabled
                -- disable = { "c", "rust" },

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }
    end
})

table.insert(plugins, { 'nvim-treesitter/nvim-treesitter-context' })

table.insert(plugins, {
    'nvim-lualine/lualine.nvim',
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
    'ahmedkhalf/project.nvim',
    config = function()
        require("project_nvim").setup {
        }

        require('telescope').load_extension('projects')
    end
})

table.insert(plugins, {
    'Pocco81/auto-save.nvim',
    config = function()
        local autosave = require("auto-save")

        autosave.setup({
            enabled = true,
            execution_message = {
                message = function() -- message to print on save
                    return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                end
            },
            trigger_events = { "InsertLeave", "TextChanged" },
            --dim = 0.18, -- dim the color of `message`
            --cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
        })
    end
})

table.insert(plugins, {
    'airblade/vim-gitgutter',
    config = function()
        vim.g.gitgutter_enabled = 1
        vim.g.gitgutter_map_keys = 0 -- Disables all keys

        local set = vim.opt

        set.signcolumn = "yes"
        set.updatetime = 100
    end
})


table.insert(plugins, {
    'romgrk/barbar.nvim',
    config = function()
        vim.g.barbar_auto_setup = false -- disable auto-setup
        require 'barbar'.setup {
            -- WARN: do not copy everything below into your config!
            --       It is just an example of what configuration options there are.
            --       The defaults are suitable for most people.

            -- Enable/disable animations
            animation = true,

            -- Enable/disable auto-hiding the tab bar when there is a single buffer
            auto_hide = true,

            -- Enable/disable current/total tabpages indicator (top right corner)
            tabpages = true,

            -- Enables/disable clickable tabs
            --  - left-click: go to buffer
            --  - middle-click: delete buffer
            clickable = true,

            -- Excludes buffers from the tabline
            exclude_ft = { 'javascript' },
            exclude_name = { 'package.json' },

            -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
            -- Valid options are 'left' (the default) and 'right'
            focus_on_close = 'left',

            -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
            hide = { extensions = true, inactive = true },

            -- Disable highlighting alternate buffers
            highlight_alternate = false,

            -- Disable highlighting file icons in inactive buffers
            highlight_inactive_file_icons = false,

            -- Enable highlighting visible buffers
            highlight_visible = true,

            icons = {
                -- Configure the base icons on the bufferline.
                buffer_index = false,
                buffer_number = false,
                button = '',
                -- Enables / disables diagnostic symbols
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
                    [vim.diagnostic.severity.WARN] = { enabled = false },
                    [vim.diagnostic.severity.INFO] = { enabled = false },
                    [vim.diagnostic.severity.HINT] = { enabled = true },
                },
                filetype = {
                    -- Sets the icon's highlight group.
                    -- If false, will use nvim-web-devicons colors
                    custom_colors = false,
                    -- Requires `nvim-web-devicons` if `true`
                    enabled = true,
                },
                separator = { left = '▎', right = '' },
                -- Configure the icons on the bufferline when modified or pinned.
                -- Supports all the base icon options.
                modified = { button = '●' },
                pinned = { button = '車', filename = true, separator = { right = '' } },
                -- Configure the icons on the bufferline based on the visibility of a buffer.
                -- Supports all the base icon options, plus `modified` and `pinned`.
                alternate = { filetype = { enabled = false } },
                current = { buffer_index = true },
                inactive = { button = '×' },
                visible = { modified = { buffer_number = false } },
            },

            -- If true, new buffers will be inserted at the start/end of the list.
            -- Default is to insert after current buffer.
            insert_at_end = true,
            insert_at_start = false,

            -- Sets the maximum padding width with which to surround each tab
            maximum_padding = 1,

            -- Sets the minimum padding width with which to surround each tab
            minimum_padding = 1,

            -- Sets the maximum buffer name length.
            maximum_length = 30,

            -- If set, the letters for each buffer in buffer-pick mode will be
            -- assigned based on their name. Otherwise or in case all letters are
            -- already assigned, the behavior is to assign letters in order of
            -- usability (see order below)
            semantic_letters = true,

            -- Set the filetypes which barbar will offset itself for
            sidebar_filetypes = {
                -- Use the default values: {event = 'BufWinLeave', text = nil}
                NvimTree = true,
                -- Or, specify the text used for the offset:
                undotree = { text = 'undotree' },
                -- Or, specify the event which the sidebar executes when leaving:
                ['neo-tree'] = { event = 'BufWipeout' },
                -- Or, specify both
                Outline = { event = 'BufWinLeave', text = 'symbols-outline' },
            },

            -- New buffer letters are assigned in this order. This order is
            -- optimal for the qwerty keyboard layout but might need adjustment
            -- for other layouts.
            letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

            -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
            -- where X is the buffer number. But only a static string is accepted here.
            no_name_title = nil,
        }
    end
})

table.insert(plugins, {
    'dbinagi/nomodoro',
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

table.insert(plugins, { 'rcarriga/nvim-notify', lazy = true })

table.insert(plugins, {
    'Pocco81/true-zen.nvim',
    lazy = true,
    config = function()
        require("true-zen").setup {
            -- your config goes here
            -- or just leave it empty :)
        }
    end
})


table.insert(plugins, { 'MunifTanjim/nui.nvim' })

table.insert(plugins, {
    'CosmicNvim/cosmic-ui',
    config = function()
        require('cosmic-ui').setup()
    end
})

table.insert(plugins, {
    'rmagatti/goto-preview',
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

table.insert(plugins, { 'ThePrimeagen/harpoon' })

table.insert(plugins, {
    'f-person/git-blame.nvim',
    lazy = true,
    config = function()
        vim.g.gitblame_enabled = " "
    end
})


-- Testing plugins
-- Plug 'stevearc/overseer.nvim'
-- Plug ('nvim-neorg/neorg', {tag = '0.0.12'})
-- Plug 'ThePrimeagen/harpoon'
-- -- Plug 'rmagatti/auto-session'
-- Plug 'tpope/vim-fugitive'
-- Plug 'j-hui/fidget.nvim'


-- *===================*
-- | LUA configuration |
-- *===================*

-- Set leader key before configurations
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup(plugins, {
    install = {
        colorscheme = { "tokyonight-night" }
    }
})

--require('custom.lualine')                                   -- lualine
--require('custom.vim-gitgutter')                             -- vim-gitgutter
--require('custom.telescope_nvim')                            -- Telescope
--require('custom.which-key_nvim')                            -- Which key setup
--require('custom.cosmic-ui')
----require('custom.overseer_nvim')
--require('custom.true-zen_nvim')
---- require('custom.neorg')
--require"fidget".setup{}

-- require("auto-session").setup {
--   log_level = "error",
--   auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
-- }


require('ckeys')

-- *========*
-- | COLORS |
-- *========*

-- vim.cmd('colorscheme nord')

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
vim.o.timeoutlen     = 500  -- Reduce timeout for leader (default 1000ms)
vim.o.termguicolors  = true
vim.o.ignorecase     = true -- Ignore case when searching
vim.o.smartcase      = true -- Switch search to case sensitive when upperletter
-- vim.o.foldmethod        = "indent"                      -- Fold based on indention levels
-- vim.o.foldnestmax       = 3                             -- Fold up to 3 nested levels

vim.cmd("noswapfile") -- Disable creating swap file
vim.cmd("set cc=80")
vim.cmd("set autoread")
vim.cmd("set ffs=unix,dos")

-- Turn manually syntax on on .cs files
vim.cmd('au BufRead,BufNewFile *.cs syntax on')

-- Enable tabs on makefiles
vim.cmd('au BufRead,BufNewFile FileType make set noexpandtab')

vim.cmd("syntax enable") -- Disable creating swap file
