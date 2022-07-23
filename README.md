# My personal Dotfiles

## Setup environments

### Windows (With WSL)

1) Install WSL to support Linux terminal
    `wsl --install -d Ubuntu`
1) Install tmux
    `sudo apt install tmux`
1) Install Fish
    `sudo apt install fish`
1) Configure fish as default shell
    `chsh -s $(which fish)`
1) Install NeoVim
    `sudo apt install neovim`
1) Execute install_wsl.bat
1) Open nvim from a command prompt and write `:PlugInstall`

### Windows (Without WSL)

1) Install NeoVim
2) Create folder nvim in `C:\Users\USER-NAME\AppData\Local\nvim`
3) Execute install_windows.bat
4) Open nvim from a command prompt and write `:PlugInstall`

### MAC

1) Install Alacritty from web: https://github.com/alacritty/alacritty/releases
1) Install tmux: `brew install tmux`
1) Install fish: `brew install fish`
1) Run `./install_mac.sh`
1) Set fish as default shell (https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262)

## Troubleshooting

### Error with VCRUNTIME140.DLL

1) Install c++ 2015: https://www.microsoft.com/en-us/download/details.aspx?id=52685

### Error "No C compiler found!"

**On Windows**
1) Install: `choco install mingw`

**On Linux**
1) Install: `sudo apt install build-essential`

### No fonts on MAC

1) Install patched font, complete version: https://www.nerdfonts.com/font-downloads

### Click not working in Alacritty

1) Close all running cmd program, like cmd or running alacritty.
1) Rename your original conhost.exe to other names like conhost.exe_bak in C:\Windows\System32\
1) Go to Windows Terminal path C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_<VERSION information>\OpenConsole.exe
    1) e.g.:C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.0.1811.0_x64__8wekyb3d8bbwe\OpenConsole.exe
1) Copy and rename OpenConsole.exe to C:\Windows\System32\conhost.exe

Reference: https://github.com/alacritty/alacritty/issues/1663

### NVIM: Grep and find config for telescope

For Grep install: `https://github.com/BurntSushi/ripgrep`
For Find install: `https://github.com/sharkdp/fd`

### NVIM: LSP not working

Run the command: `:LspInstall` in the file not working

### NVIM: Syntax colors not working

Run the command: `:TSUpdate`

### NVIM: LSPInstaller: No directory .cache

Creates the folders `.cache/nvim`

### NVIM: LSPInstaller: No unzip installer

Install: `sudo apt-get install unzip`
