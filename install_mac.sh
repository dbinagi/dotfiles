cp nvim/init.lua ~/.config/nvim
#cp nvim/ginit.vim ~/.config/nvim

cp -R nvim/autoload ~/.config/nvim
cp -R nvim/colors ~/.config/nvim
cp -R nvim/lua ~/.config/nvim
cp -R nvim/syntax ~/.config/nvim
cp -R nvim/after ~/.config/nvim

cp -R fish ~/.config
cp -R omf ~/.config

rm -Rf ~/.config/tmux
mkdir ~/.config/tmux
cp tmux/.tmux_mac.conf ~/.config/tmux/.tmux.conf
cp tmux/.tmux_common.conf ~/.config/tmux/.tmux_common.conf

cp -R tmuxinator ~/.config

cp -R lsd ~/.config

cp wezterm/.wezterm_mac.lua ~/.wezterm.lua 
cp "backgrounds/Twilight Prophet.jpg" ~/wezterm/background.jpg

mkdir -p ~/.config/alacritty && cp alacritty/alacritty_mac.yml ~/.config/alacritty/alacritty.yml
