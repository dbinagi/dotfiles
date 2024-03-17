" Maximize screen
" call GuiWindowMaximized(1)

" Remove tab from nvim qt
" GuiTabline 0

" Start Fullscreen
" call GuiWindowFullScreen(1)

" Font and size
" GuiFont! Hack:h14
"

if vim.g.neovide then
    vim.o.guifont = "Hack:h14"
end
