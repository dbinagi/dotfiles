let mapleader=" "
let maplocalleader=" "

" =======
" PLUGINS
" =======

call plug#begin()

" Welcome screen
Plug 'goolord/alpha-nvim'
" Plug 'mhinz/vim-startify'

" Status Line
Plug 'nvim-lualine/lualine.nvim'

" Color scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Icons (dependency with other plugins)
Plug 'kyazdani42/nvim-web-devicons'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'

" Completition Engine
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippet
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Control P
Plug 'ctrlpvim/ctrlp.vim'

" Improve terminal
Plug 'vimlab/split-term.vim'

" Highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" File Explorer
Plug 'scrooloose/nerdtree'

" NERDTree complementary plugins
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Telescope
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'OmniSharp/omnisharp-vim'

call plug#end()

" Load Custom LUA configuration
" =============================
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

" PLUGIN - NERDTree configuration
" ===============================

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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
