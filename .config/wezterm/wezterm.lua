local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	font = wezterm.font("MesloLGS Nerd Font"),
	font_size = 16,
	window_decorations = "RESIZE",
	-- window_background_opacity = 0.7,
	macos_window_background_blur = 11,
	enable_tab_bar = false,
	default_cursor_style = "BlinkingUnderline",
	color_scheme = "Nord (Gogh)",
	background = {
		{
			source = {
				File = "/Users/michael.grunewalder/.config/assets/wallpaper.png",
			},
			hsb = {
				hue = 1.0,
				saturation = 1.02,
				brightness = 0.25,
			},
			width = "100%",
			height= "100%",
		},
		{
			source = {
				Color = "#282c35",
			},
			width = "100%",
			height = "100%",
			opacity = 0.75,
		}
		
	},
	window_padding = {
		left = 20, 
		right = 20,
		top = 10,
		bottom = 10,
	}
}

return config
