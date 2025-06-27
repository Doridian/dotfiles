-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder() -- Pull in the wezterm API

config.ssh_domains = {
  {
    name = 'bengalfox',
    remote_address = 'bengalfox.foxden.network',
    username = 'doridian',
  },
  {
    name = 'islandfox',
    remote_address = 'islandfox.foxden.network',
    username = 'doridian',
  },
  {
    name = 'icefox',
    remote_address = 'icefox.doridian.net',
    username = 'doridian',
  },
  {
    name = 'capefox',
    remote_address = 'capefox.foxden.network',
    username = 'doridian',
  },
  {
    name = 'capefox-wired',
    remote_address = 'capefox-wired.foxden.network',
    username = 'doridian',
  },
  {
    name = 'fennec',
    remote_address = 'fennec.foxden.network',
    username = 'doridian',
  },
}

config.color_scheme = 'shades-of-purple'

config.colors = {
  tab_bar = {
    inactive_tab = {
      bg_color = "#25143d",
      fg_color = "#90879c",
    },
    inactive_tab_hover = {
      bg_color = "#25143d",
      fg_color = "#ebddff",
    },
    active_tab = {
      bg_color = "#39294e",
      fg_color = "#ebddff",
    },
    new_tab = {
      bg_color = "#25143d",
      fg_color = "#90879c",
    },
    new_tab_hover = {
      bg_color = "#25143d",
      fg_color = "#ebddff",
    },
  },
}

config.window_frame = {
  inactive_titlebar_bg = '#25143d',
  active_titlebar_bg = '#25143d',
  inactive_titlebar_fg = '#cccccc',
  active_titlebar_fg = '#ffffff',
  inactive_titlebar_border_bottom = '#25143d',
  active_titlebar_border_bottom = '#25143d',
  button_fg = '#cccccc',
  button_bg = '#25143d',
  button_hover_fg = '#ffffff',
  button_hover_bg = '#3b3052',
}

config.background = {
  {
    source = {
      Color = '#0c0b28',
    },
    height = "100%",
    width = "100%",
  },
  --[[{
    source = {
      File = '/home/doridian/Pictures/Commissions/doripaw_alphabg.png'
    },
    hsb = {
      brightness = 0.05,
    },
    opacity = 0.10,
    height = "Contain",
    width = "Contain",
    horizontal_align = "Center",
    vertical_align = "Middle",
    repeat_x = "NoRepeat",
    repeat_y = "NoRepeat",
  },]]
}

config.window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3rd
  brightness = 0.25,

  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,

  -- You can adjust the saturation also.
  saturation = 1.0,
}

config.window_background_opacity = 1.0

return config
