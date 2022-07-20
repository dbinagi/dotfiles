xcopy nvim nvim_tmp /E/H/C/I/Y
cd nvim_tmp
for /R %%G in (*) do dos2unix -n "%%G" "%%G"
cd ..

xcopy nvim_tmp \\wsl$\Ubuntu\home\bini\.config\nvim /E/H/C/I/Y
xcopy fish \\wsl$\Ubuntu\home\bini\.config\fish /E/H/C/I/Y

xcopy tmux\.tmux.conf \\wsl$\Ubuntu\home\bini\ /E/H/C/I/Y

xcopy alacritty\alacritty_windows.yml %APPDATA%\alacritty\alacritty.yml* /Y

rmdir /s /q nvim_tmp

set /p DUMMY=Hit ENTER to continue...