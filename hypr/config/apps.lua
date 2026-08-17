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

local ssh_auth_sock = os.getenv("XDG_DATA_HOME") .. "/ssh-agent.sock"
local startup = {
	"waybar",
	"hyprpaper",
	"dunst",
	"keepassxc --minimized",
	"ssh-agent -D -a \"" .. ssh_auth_sock .. "\"",
	"vorta",
	options.clipboardWatch,
	"/usr/lib/polkit-kde-authentication-agent-1",
	"vicinae server",
	"kbuildsycoca6" -- fix kde file associations
}

hl.on("hyprland.start", function()
	for _, app in ipairs(startup) do
		hl.exec_cmd(app)
	end
end)

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("SSH_AUTH_SOCK", ssh_auth_sock)

return options
