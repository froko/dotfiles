local wezterm = require("wezterm")

local config = {
  color_scheme = 'Catppuccin Mocha',
  font = wezterm.font 'JetBrains Mono',
  enable_tab_bar = false,
  native_macos_fullscreen_mode = true,
  macos_window_background_blur = 30,
  window_background_opacity = 0.6,
  window_decorations = "RESIZE",
  keys = {
    {
      key = "n",
      mods = "SHIFT|CTRL",
      action = wezterm.action.ToggleFullScreen,
    }
  },
  mouse_bindings = {
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	}
}

return config
