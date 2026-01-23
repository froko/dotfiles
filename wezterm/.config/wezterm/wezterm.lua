local wezterm = require("wezterm")

local config = {
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("JetBrains Mono"),
	font_size = 14.0,
	enable_tab_bar = false,
	native_macos_fullscreen_mode = true,
	window_decorations = "RESIZE",
	window_background_opacity = 0.9,
	keys = {
		{
			key = "n",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}

return config
