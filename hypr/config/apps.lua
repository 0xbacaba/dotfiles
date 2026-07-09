local options = {
	terminal = "konsole",
	fileManager = "dolphin",
	menu = "vicinae toggle",

	-- This    vvvvvvvvvvvvvvvv is required to use the kde filepicker in firefox-based browsers
	browser = "GTK_USE_PORTAL=1 zen-browser",
	spotifyClient = "spotify",
	discordClient = "vesktop",
	screenshotUtility = "hyprshot -m region --clipboard-only -s -z",

	clipboardWatch = "clipse -listen",
	clipboardShow = "alacritty --class clipse -e 'clipse'",

	screenlockUtility = "hyprlock",
}

local startup = {
	"waybar",
	"hyprpaper",
	"dunst",
	"/usr/bin/kwalletd6",
	"vorta",
	options.clipboardWatch,
	"/usr/lib/polkit-kde-authentication-agent-1",
	"vicinae server",
}

hl.on("hyprland.start", function()
	for _, app in ipairs(startup) do
		hl.exec_cmd(app)
	end
end)

hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("XDG_MENU_PREFIX", "arch-")

return options
