local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'Tokyo Night (Gogh)'
config.font = wezterm.font 'Hack Nerd Font'
config.hide_tab_bar_if_only_one_tab = true

config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

config.keys = {
  {
    key = 'C',
    mods = 'CTRL',
    action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
  },
}

-- Set background
config.background = {
    {
        source = {
            File = '/Users/diego/wezterm/background.jpg'
        },
        hsb = {
            brightness = 0.03,
            hue = 1.0,
            saturation = 1.0,
        },
        opacity = 1
    }
}

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

return config
