copy nvim\init.lua %LocalAppData%\nvim\init.lua
copy nvim\ginit.vim %LocalAppData%\nvim\ginit.vim

xcopy nvim\autoload %LocalAppData%\nvim\autoload /E/H/C/I/Y
xcopy nvim\colors %LocalAppData%\nvim\colors /E/H/C/I/Y
xcopy nvim\lua %LocalAppData%\nvim\lua /E/H/C/I/Y
xcopy nvim\syntax %LocalAppData%\nvim\syntax /E/H/C/I/Y

set /p DUMMY=Hit ENTER to continue...