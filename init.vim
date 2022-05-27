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
" Plug 'neovim/nvim-lspconfig'

" Completition Engine
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Telescope
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'


" File Explorer
" Plug 'kyazdani42/nvim-tree.lua'

" Highlight
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Control P
Plug 'ctrlpvim/ctrlp.vim'

" Improve terminal
Plug 'vimlab/split-term.vim'

" LINTER
" Plug 'dense-analysis/ale'

call plug#end()

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
 
" PLUGIN - nvim-cmp
" =================

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
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
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
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

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
EOF
 

" PLUPGIN - lualine
" =================

lua <<EOF
    local lualine = require'lualine'
    lualine.setup({
        options = {
            theme = 'tokyonight'
        }
    })
EOF

" PLUGIN - alpha-vim
" ==================

lua require('alpha').setup(require('alpha.themes.startify').config)

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

let mapleader=";"
