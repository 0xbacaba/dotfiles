local shared = require("config.shared")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 3,

		border_size = 2,

		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		allow_tearing = true,

		layout = shared.layout.name,

		col = {
			active_border = { colors = { "#33ccffee", "#00ff99ee" }, angle = 45 },
			inactive_border = "#595959aa",
		},
	},

	ecosystem = {
		enforce_permissions = true,
	},

	decoration = {
		rounding = 10,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		blur = {
			enabled = true,
			size = 3,
			passes = 1,

			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
		force_split = 2,
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},

	input = {
		kb_layout = "de",
		kb_options = "caps:escape",

		follow_mouse = 1,

		sensitivity = 0,
		repeat_delay = 300,
		repeat_rate = 30,

		touchpad = {
			natural_scroll = false,
		},
	},
})

local customCurve = "custom"
local defaultCurve = "default"
hl.curve(customCurve, { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 7,
	bezier = customCurve,
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 7,
	bezier = defaultCurve,
	style = "popin 80%",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 10,
	bezier = defaultCurve,
})
hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 8,
	bezier = defaultCurve,
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 7,
	bezier = defaultCurve,
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 6,
	bezier = defaultCurve,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
