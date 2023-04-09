local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'Tokyo Night (Gogh)'
config.font = wezterm.font 'Hack'
config.hide_tab_bar_if_only_one_tab = true

-- Starts full screen
local mux = wezterm.mux
wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
	window:gui_window():toggle_fullscreen()
end)

-- Configure WSL on Windows
local wsl_domains = wezterm.default_wsl_domains()
for idx, dom in ipairs(wsl_domains) do
    dom.default_prog = { 'fish' }
end
config.wsl_domains = wsl_domains
config.default_domain = 'WSL:Ubuntu'

-- Set background
config.background = {
    {
        source = {
            File = 'C:/Users/Bini/wezterm/background.jpg'
        },
        hsb = {
            brightness = 0.03,
            hue = 1.0,
            saturation = 1.0,
        },
        opacity = 0.9
    }
}

return config
