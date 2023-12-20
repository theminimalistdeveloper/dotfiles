local wezterm = require 'wezterm'

local config = {}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.enable_tab_bar = false
config.font = wezterm.font("Monaspace Neon", { weight = 'Bold' })
config.font_size = 13
config.color_scheme = 'Overnight Slumber'

config.window_background_opacity = 0.8
config.text_background_opacity = 0.8

return config
