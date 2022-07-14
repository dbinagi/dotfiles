let mapleader=" "
let maplocalleader=" "

" =======
" PLUGINS
" =======

call plug#begin()

Plug 'goolord/alpha-nvim'                                       " Welcome screen
Plug 'nvim-lualine/lualine.nvim'                                " Status Line
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }              " Color scheme
Plug 'kyazdani42/nvim-web-devicons'                             " Icons (dependency with other plugins)
Plug 'neovim/nvim-lspconfig'                                    " LSP
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}     " Highlight
Plug 'nvim-lua/plenary.nvim'                                    " Library for Telescope
Plug 'nvim-telescope/telescope.nvim'                            " Telescope
Plug 'nvim-telescope/telescope-file-browser.nvim'               " File explorer (using Telescope)
Plug 'Pocco81/AutoSave.nvim'                                    " Autosave
Plug 'airblade/vim-gitgutter'                                   " Git functions
Plug 'liuchengxu/vim-which-key'                                 " Which key
Plug 'romgrk/barbar.nvim'                                       " Improved bar/tabs
Plug 'ahmedkhalf/project.nvim'                                  " Project management

" Completition Engine
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippet
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Improve terminal
Plug 'vimlab/split-term.vim'

Plug 'OmniSharp/omnisharp-vim'

call plug#end()

" Load Custom LUA configuration
" =============================
lua require('ckeys')
"lspconfig
lua require('customlspconfig')
"nvim-cmp
lua require('customnvimcmp')
"lualine
lua require('customlualine')
" alpha
lua require('customalpha')
" nvim-treesitter
lua require('customtreesitter')
" vim-nerdtree-syntax-highlight
lua require('customtreesyntaxhighlight')
" vim-gitgutter
lua require('customgitgutter')
" Autosave
lua require('customautosave')
" Telescope
lua require('ctelescope')
" WhichKey
lua require('cwhichkey')
" project management
lua require('cproject')
" bar
lua require('cbar')

" au Syntax cs    runtime! syntax/csharp.vim
augroup filetype                                                     
  au BufRead,BufNewFile *.cs    set filetype=csharp         
augroup END                                                          

au Syntax csharp    so ~/.vim/syntax/csharp.vim          

let g:OmniSharp_selector_ui = 'ctrlp'

" COLORS
" ======
set termguicolors
" colorscheme nord
colorscheme tokyonight

" GENERAL CONFIGURATION
" ---------------------
set number			        " Show line number
set showmatch			    " Show matching
set hlsearch			    " Highlight search
set clipboard+=unnamedplus	" Copy and Paste from system clipboard
set tabstop=4			    " Columns occupied by tab
set softtabstop=4		    " Multiple spaces as tab
set shiftwidth=4            " Width for autoindents
set expandtab			    " Converts tab to spaces
set autoindent              " Indent a new lines the same as before
set cc=80                   " Border of 80
syntax on                   " Syntax highlight
set mouse=a                 " Enable mouse click
set cursorline              " Highlight current cursorline
set noswapfile              " Disable creating swap file
set splitright
set completeopt=menu,menuone,noselect
set showcmd
set timeoutlen=500          " Reduce timeout for leader (default 1000ms)
