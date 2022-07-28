
-- *=========*
-- | PLUGINS |
-- *=========*

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'goolord/alpha-nvim'                                               -- Welcome screen
Plug 'nvim-lualine/lualine.nvim'                                        -- Status Line
Plug('folke/tokyonight.nvim', { branch= 'main' })                       -- Color scheme
Plug 'kyazdani42/nvim-web-devicons'                                     -- Icons (dependency with other plugins)
Plug 'neovim/nvim-lspconfig'                                            -- LSP
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']}) -- Highlight
Plug 'nvim-lua/plenary.nvim'                                            -- Library for Telescope
Plug 'nvim-telescope/telescope.nvim'                                    -- Telescope
Plug 'nvim-telescope/telescope-file-browser.nvim'                       -- File explorer (using Telescope)
Plug 'ahmedkhalf/project.nvim'                                          -- Project management
Plug 'Pocco81/AutoSave.nvim'                                            -- Autosave
Plug 'airblade/vim-gitgutter'                                           -- Git functions
Plug 'liuchengxu/vim-which-key'                                         -- Which key
Plug 'AckslD/nvim-whichkey-setup.lua'                                   -- Which key: Setup in LUA
Plug 'romgrk/barbar.nvim'                                               -- Improved bar/tabs
Plug 'williamboman/nvim-lsp-installer'                                  -- LSP Installer
Plug 'hrsh7th/cmp-nvim-lsp'                                             -- Completition LSP
Plug 'hrsh7th/cmp-buffer'                                               -- Completition Buffer
Plug 'hrsh7th/cmp-path'                                                 -- Completition Path
Plug 'hrsh7th/cmp-cmdline'                                              -- Completition command line
Plug 'hrsh7th/nvim-cmp'                                                 -- Completition
Plug 'hrsh7th/vim-vsnip'                                                -- Snippet
Plug 'hrsh7th/vim-vsnip-integ'                                          -- Snippet dependency

Plug 'numToStr/Comment.nvim'

Plug 'MunifTanjim/nui.nvim'
Plug 'CosmicNvim/cosmic-ui'

Plug 'rmagatti/goto-preview'
Plug 'stevearc/overseer.nvim'

-- Plug 'wthollingsworth/pomodoro.nvim'


vim.call('plug#end')

-- *===================*
-- | LUA configuration |
-- *===================*

-- Set leader key before configurations

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('ckeys')
require('custom.nvim-lspconfig')                            -- nvim-lspconfig
require('custom.nvim-cmp')                                  -- nvim-cmp
require('custom.lualine')                                   -- lualine
require('custom.alpha-nvim')                                -- Alpha
require('custom.nvim-treesitter')                           -- nvim-treesitter
require('custom.vim-gitgutter')                             -- vim-gitgutter
require('custom.AutoSave')                                  -- AutoSave
require('custom.telescope_nvim')                            -- Telescope
require('custom.project_nvim')                              -- Telescope: Project
require('custom.barbar')                                    -- barbar
require('custom.nvim-whichkey-setup')                       -- Which key setup
require('custom.Comment_nvim')
require('custom.cosmic-ui')
require('custom.goto-preview')
require('custom.overseer_nvim')
-- require('custom.pomodoro_nvim')

-- *========*
-- | COLORS |
-- *========*

-- vim.cmd('colorscheme nord')
vim.cmd('colorscheme tokyonight')

-- *=======================*
-- | GENERAL CONFIGURATION |
-- *=======================*

vim.o.number            = true                          -- Show line number
vim.o.relativenumber    = true                          -- Show relative from cursor to other lines
vim.o.showmatch         = true			                -- Show matching
vim.o.hlsearch          = true			                -- Highlight search
vim.o.clipboard         = "unnamedplus"                 -- Copy and Paste from system clipboard
vim.o.tabstop           = 4			                    -- Columns occupied by tab
vim.o.softtabstop       = 4		                        -- Multiple spaces as tab
vim.o.shiftwidth        = 4                             -- Width for autoindents
vim.o.expandtab         = true			                -- Converts tab to spaces
vim.o.autoindent        = true                          -- Indent a new lines the same as before
vim.o.mouse             = "a"                           -- Enable mouse click
vim.o.cursorline        = true                          -- Highlight current cursorline
vim.o.splitright        = true
vim.o.completeopt       = "menu,menuone,noselect"
vim.o.showcmd           = true
vim.o.timeoutlen        = 500                           -- Reduce timeout for leader (default 1000ms)
vim.o.termguicolors     = true
vim.o.ignorecase        = true                          -- Ignore case when searching
vim.o.smartcase         = true                          -- Switch search to case sensitive when upperletter
-- vim.o.foldmethod        = "indent"                      -- Fold based on indention levels
-- vim.o.foldnestmax       = 3                             -- Fold up to 3 nested levels

vim.cmd("noswapfile")                               -- Disable creating swap file
vim.cmd("set cc=80")

-- Turn manually syntax on on .cs files
vim.cmd('au BufRead,BufNewFile *.cs syntax on')
vim.cmd("syntax enable")                               -- Disable creating swap file

