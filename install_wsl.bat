xcopy nvim nvim_tmp /E/H/C/I/Y
cd nvim_tmp
for /R %%G in (*) do dos2unix -n "%%G" "%%G"
cd ..

xcopy nvim_tmp \\wsl$\Ubuntu\home\bini\.config\nvim /E/H/C/I/Y

xcopy fish \\wsl$\Ubuntu\home\bini\.config\fish /E/H/C/I/Y
xcopy omf \\wsl$\Ubuntu\home\bini\.config\omf /E/H/C/I/Y

dos2unix -n tmux\.tmux_wsl.conf tmux\.tmux_tmp.conf
xcopy tmux\.tmux_tmp.conf \\wsl$\Ubuntu\home\bini\.tmux.conf /E/H/C/I/Y
DEL /F /Q tmux\.tmux_tmp.conf

xcopy alacritty\alacritty_windows.yml %APPDATA%\alacritty\alacritty.yml* /Y

rmdir /s /q nvim_tmp

set /p DUMMY=Hit ENTER to continue...