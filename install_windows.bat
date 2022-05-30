copy init.vim %LocalAppData%\nvim\init.vim
copy ginit.vim %LocalAppData%\nvim\ginit.vim

xcopy autoload %LocalAppData%\nvim\autoload /E/H/C/I/Y
xcopy colors %LocalAppData%\nvim\colors /E/H/C/I/Y
xcopy lua %LocalAppData%\nvim\lua /E/H/C/I/Y
xcopy syntax %LocalAppData%\nvim\syntax /E/H/C/I/Y

read -n 1 -s
