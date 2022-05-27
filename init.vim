let mapleader=" "
let maplocalleader=" "

" =======
" PLUGINS
" =======

call plug#begin()

" Welcome screen
Plug 'goolord/alpha-nvim'

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

" Telescope
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" File Explorer
" Plug 'kyazdani42/nvim-tree.lua'

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




" PLUGIN - NVIM-TREE
" ==================
" let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
" let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
" let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
" let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
" let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
" let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
" let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
" let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
" let g:nvim_tree_create_in_closed_folder = 1 "0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
" let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
" let g:nvim_tree_show_icons = {
"     \ 'git': 1,
"     \ 'folders': 1,
"     \ 'files': 0,
"     \ 'folder_arrows': 0,
"     \ }
" "If 0, do not show the icons for one of 'git' 'folder' and 'files'
" "1 by default, notice that if 'files' is 1, it will only display
" "if nvim-web-devicons is installed and on your runtimepath.
" "if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
" "but this will not work when you set renderer.indent_markers.enable (because of UI conflict)
" 
" " default will show icon by default if no icon is provided
" " default shows no icon by default
" let g:nvim_tree_icons = {
"     \ 'default': "",
"     \ 'symlink': "",
"     \ 'git': {
"     \   'unstaged': "✗",
"     \   'staged': "✓",
"     \   'unmerged': "",
"     \   'renamed': "➜",
"     \   'untracked': "★",
"     \   'deleted': "",
"     \   'ignored': "◌"
"     \   },
"     \ 'folder': {
"     \   'arrow_open': "",
"     \   'arrow_closed': "",
"     \   'default': "",
"     \   'open': "",
"     \   'empty': "",
"     \   'empty_open': "",
"     \   'symlink': "",
"     \   'symlink_open': "",
"     \   }
"     \ }
" 
" nnoremap <C-n> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
" " More available functions:
" " NvimTreeOpen
" " NvimTreeClose
" " NvimTreeFocus
" " NvimTreeFindFileToggle
" " NvimTreeResize
" " NvimTreeCollapse
" " NvimTreeCollapseKeepBuffers
" 
" " a list of groups can be found at `:help nvim_tree_highlight`
" " highlight NvimTreeFolderIcon guibg=blue
" 
" " lua require('nvim-tree').setup()
 

 


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
