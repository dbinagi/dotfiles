# My personal configuration for NVIM

## Windows

1) Install NVIM with MSI installer
2) Create folder nvim in `C:\Users\USER-NAME\AppData\Local\nvim`
3) Execute install_windows.bat
4) Open nvim from a command prompt and write `:PlugInstall`
5) For C# execute: `:CocInstall coc-omnisharp`

### LSP Config

**LUA**

1) Install: https://github.com/sumneko/lua-language-server/releases
1) Add it to PATH

**VIM**

1) Execute `npm install -g vim-language-server`

### Troubleshooting

#### Error with VCRUNTIME140.DLL

1) Install c++ 2015: https://www.microsoft.com/en-us/download/details.aspx?id=52685
