:: NVIM

xcopy nvim nvim_tmp /E/H/C/I/Y
cd nvim_tmp
for /R %%G in (*) do ..\vendor\dos2unix -n "%%G" "%%G"
cd ..
xcopy nvim_tmp \\wsl$\Ubuntu\home\bini\.config\nvim /E/H/C/I/Y

:: FISH

xcopy fish \\wsl$\Ubuntu\home\bini\.config\fish /E/H/C/I/Y

xcopy omf omf_tmp /E/H/C/I/Y
cd omf_tmp
for /R %%G in (*) do ..\vendor\dos2unix -n "%%G" "%%G"
cd ..
xcopy omf_tmp \\wsl$\Ubuntu\home\bini\.config\omf /E/H/C/I/Y

:: TMUX

vendor\dos2unix -n tmux\.tmux_wsl.conf tmux\.tmux_tmp.conf
copy tmux\.tmux_tmp.conf \\wsl$\Ubuntu\home\bini\.tmux.conf

:: WEZTERM

xcopy "backgrounds\Twilight Prophet.jpg" C:\Users\Bini\wezterm\background.jpg* /I /Y
copy wezterm\.wezterm.lua %USERPROFILE%

:: KITTY

vendor\dos2unix -n kitty\kitty.conf kitty\kitty_tmp.conf
copy kitty\kitty_tmp.conf \\wsl$\Ubuntu\home\bini\kitty\kitty.conf

:: FONTS

xcopy fonts \\wsl$\Ubuntu\home\bini\.fonts /E/H/C/I/Y

:: Colors for ls

xcopy dircolors\.dircolors \\wsl$\Ubuntu\home\bini\.dircolors* /Y

:: Clean temp folders

rmdir /s /q nvim_tmp
rmdir /s /q omf_tmp
DEL /F /Q tmux\.tmux_tmp.conf
DEL /F /Q kitty\kitty_tmp.conf
set /p DUMMY=Hit ENTER to continue...
