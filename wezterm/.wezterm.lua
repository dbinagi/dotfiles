local wezterm = require 'wezterm'

local image_path = "C:/Users/SirDi/wezterm/background.jpg"
if os.getenv("HOME") then
     image_path = os.getenv("HOME") .. "/wezterm/background.jpg"
end

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'Tokyo Night (Gogh)'
config.font = wezterm.font_with_fallback {
  'Hack Nerd Font',
  'Hack Nerd Font Mono',
  'Hack',
  'Hack Nerd',
}
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

-- Map keys
local act = wezterm.action

config.keys = {
  -- paste from the clipboard
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  -- paste from the primary selection
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
}

-- Set background
config.background = {
    {
        source = {
            -- File = 'C:/Users/Bini/wezterm/background.jpg'
            File = image_path
        },
        hsb = {
            brightness = 0.03,
            hue = 1.0,
            saturation = 1.0,
        },
        opacity = 1,
    }
}

return config
