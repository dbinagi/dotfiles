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

#### On MAC

Run the command: brew install lua-language-server

**VIM**

1) Execute `npm install -g vim-language-server`

**C#**

1) Execute `dotnet tool install --global csharp-ls`
2) For Unity solutions install corresponding version of SDK
   https://dotnet.microsoft.com/en-us/download/dotnet-framework/net471

**Python**

1) Execute: `python -m pip install python-lsp-server`
2) Execute: `python -m pip install python-language-server[all]`

## Grep config for telescope

Install dependency: `https://github.com/BurntSushi/ripgrep`

### Troubleshooting

#### Error with VCRUNTIME140.DLL

1) Install c++ 2015: https://www.microsoft.com/en-us/download/details.aspx?id=52685

#### Error "No C compiler found!"

1) Install: `choco install mingw`

#### No fonts on MAC

1) Install patched font, complete version: https://www.nerdfonts.com/font-downloads
