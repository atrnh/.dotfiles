local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font({
	family = "FiraCode Nerd Font",
	weight = "Regular",
	harfbuzz_features = { "cv11", "ss03", "cv29", "cv31" },
})
config.font_size = 11.8
config.line_height = 1.1

config.window_decorations = "RESIZE"

-- Tab settings
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	active_titlebar_bg = "#1E1E2E",
	font = wezterm.font({
		family = "SF Pro Rounded",
		weight = "Medium",
	}),
	font_size = 12.8,
}
config.command_palette_fg_color = "#cdd6f4"
config.command_palette_bg_color = "#181825"
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#585b70",
			fg_color = "#f2cdcd",
		},
		inactive_tab = {
			bg_color = "#1E1E2E",
			fg_color = "#6c7086",
			italic = true,
		},
		inactive_tab_edge = "#181925",
		inactive_tab_hover = {
			bg_color = "313244",
			fg_color = "#575A6F",
		},
		new_tab = {
			bg_color = "#91ACEE",
			fg_color = "#1E1E2E",
		},
		new_tab_hover = {
			bg_color = "#F2CDCD",
			fg_color = "#1E1E2E",
		},
	},
}

-- Keybindings
config.keys = {
	-- Disable this? Because my fzf keybindings stopped working idk
	{
		key = "Insert",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "Insert",
		mods = "SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "C",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "p",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "m",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- Assignments
	{
		key = "P",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette,
	},
}

config.unix_domains = {
	{
		name = "unix",
	},
}
config.default_gui_startup_args = { "connect", "unix" }

return config
