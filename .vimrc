
" PLUGIN - PATHOGEN
" -----------------

call pathogen#infect()
syntax on
filetype plugin indent on

" PLUGIN - NerdTree
" -----------------

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" PLUGIN - ctrlp.vim
" ------------------

set runtimepath^=~/.vim/bundle/ctrlp.vim

" KEYS
" ----

set backspace=indent,eol,start  " Backspacing

" FONTS
" -----

"set guifont=Bitstream\ Vera\ Sans\ Mono:h13
"set guifont=Lotion\ With\ Ligatures:h13
"set guifont=Meslo\ LG\ M:h13
set guifont=CozetteVector:h11

" COLOR - NordVim
" ---------------
set termguicolors
colorscheme nord

" UI Config
" ---------
set guioptions-=T  "remove menu bar
set guioptions-=m  "remove menu bar
set guioptions-=r  "remove scrollbar
set belloff=all "Mute audio

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif
