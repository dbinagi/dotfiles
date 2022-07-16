-- *=========*
-- | PLUGINS |
-- *=========*

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'goolord/alpha-nvim'                                               -- Welcome screen
Plug 'nvim-lualine/lualine.nvim'                                        -- Status Line
Plug('folke/tokyonight.nvim', { branch= 'main' })                      -- Color scheme
Plug 'kyazdani42/nvim-web-devicons'                                     -- Icons (dependency with other plugins)
Plug 'neovim/nvim-lspconfig'                                            -- LSP
--Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})  -- Highlight
Plug 'nvim-treesitter/nvim-treesitter'                                  -- Highlight
Plug 'nvim-lua/plenary.nvim'                                            -- Library for Telescope
Plug 'nvim-telescope/telescope.nvim'                                    -- Telescope
Plug 'nvim-telescope/telescope-file-browser.nvim'                       -- File explorer (using Telescope)
Plug 'Pocco81/AutoSave.nvim'                                            -- Autosave
Plug 'airblade/vim-gitgutter'                                           -- Git functions
Plug 'liuchengxu/vim-which-key'                                         -- Which key
Plug 'romgrk/barbar.nvim'                                               -- Improved bar/tabs
Plug 'ahmedkhalf/project.nvim'                                          -- Project management
Plug 'williamboman/nvim-lsp-installer'                                  -- LSP Installer
Plug 'hrsh7th/cmp-nvim-lsp'                                             -- Completition LSP
Plug 'hrsh7th/cmp-buffer'                                               -- Completition Buffer
Plug 'hrsh7th/cmp-path'                                                 -- Completition Path
Plug 'hrsh7th/cmp-cmdline'                                              -- Completition command line
Plug 'hrsh7th/nvim-cmp'                                                 -- Completition
Plug 'hrsh7th/vim-vsnip'                                                -- Snippet
Plug 'hrsh7th/vim-vsnip-integ'                                          -- Snippet dependency
Plug 'vimlab/split-term.vim'                                            -- Terminal improvements

vim.call('plug#end')

-- *===================*
-- | LUA configuration |
-- *===================*

-- Set leader key before configurations

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('ckeys')
require('custom.nvim-lspconfig')                            -- nvim-lspconfig
-- nvim-cmp
require('customnvimcmp')
-- lualine
require('customlualine')
-- alpha
require('customalpha')
-- nvim-treesitter
require('customtreesitter')
-- vim-nerdtree-syntax-highlight
require('customtreesyntaxhighlight')
-- vim-gitgutter
require('customgitgutter')
-- Autosave
require('customautosave')
-- Telescope
require('ctelescope')
-- WhichKey
require('cwhichkey')
-- project management
require('cproject')
-- bar
require('cbar')

-- *========*
-- | COLORS |
-- *========*

-- vim.cmd('colorscheme nord')
vim.cmd('colorscheme tokyonight')

-- *=======================*
-- | GENERAL CONFIGURATION |
-- *=======================*

vim.o.number = true			            -- Show line number
vim.o.showmatch = true			        -- Show matching
vim.o.hlsearch = true			        -- Highlight search
vim.o.clipboard = "unnamedplus"                  -- Copy and Paste from system clipboard
vim.o.tabstop = 4			            -- Columns occupied by tab
vim.o.softtabstop = 4		            -- Multiple spaces as tab
vim.o.shiftwidth = 4                    -- Width for autoindents
vim.o.expandtab = true			        -- Converts tab to spaces
vim.o.autoindent = true                 -- Indent a new lines the same as before
vim.o.cc = 80                           -- Border of 80
vim.cmd("syntax on")                    -- Syntax highlight
vim.o.mouse = "a"                      -- Enable mouse click
vim.o.cursorline = true                 -- Highlight current cursorline
vim.cmd("noswapfile")                 -- Disable creating swap file
vim.o.splitright = true
vim.o.completeopt = "menu,menuone,noselect"
vim.o.showcmd = true
vim.o.timeoutlen = 500                  -- Reduce timeout for leader (default 1000ms)
vim.o.termguicolors = true

