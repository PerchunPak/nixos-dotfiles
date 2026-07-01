-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -s b -- swaybg")
	hl.exec_cmd("uwsm app -- zen-beta")
	hl.exec_cmd("uwsm app -- equibop", { workspace = "3 silent" })
	hl.exec_cmd("uwsm app -- steam")
	hl.exec_cmd("uwsm app -- @spawn-btop-workspace@", {
		workspace = "special:btop silent",
	})

	if "@econom_internet_traffic@" ~= "true" then
		hl.exec_cmd("uwsm app -s b -- variety")
	end
end)

---------------------
---- KEYBINDINGS ----
---------------------

-- Launch applications
hl.bind("SUPER + A", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("@rofi-calc-script@"))
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("@rofi-calc-with-copy@"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + K", hl.dsp.exec_cmd("@wlogout-script@"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("cliphistory"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("variety --next"))
hl.bind("ALT + F8", hl.dsp.exec_cmd("@autoclicker-script@"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("variety --previous"))

-- Window actions
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + P", hl.dsp.window.pin({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + G", hl.dsp.window.float({ action = "toggle" }))

-- Scrolling workspaces
hl.bind("SUPER + CTRL + H", hl.dsp.layout("move -col"))
hl.bind("SUPER + CTRL + L", hl.dsp.layout("move +col"))
hl.bind("SUPER + bracketleft", hl.dsp.layout("consume_or_expel prev"))
hl.bind("SUPER + bracketright", hl.dsp.layout("consume_or_expel next"))
hl.bind("SUPER + equal", hl.dsp.layout("colresize +0.05"))
hl.bind("SUPER + minus", hl.dsp.layout("colresize -0.05"))
hl.bind("SUPER + SHIFT + equal", hl.dsp.layout("colresize 0.5"))
hl.bind("SUPER + SHIFT + minus", hl.dsp.layout("colresize 1"))
hl.bind("SUPER + SHIFT + P", hl.dsp.layout("promote"))

-- Move focus with mainMod + arrow keys
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + Q", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + W", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + E", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + R", hl.dsp.focus({ workspace = 8 }))

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + W", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + E", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + R", hl.dsp.window.move({ workspace = 8 }))

-- Special workspace
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + N", hl.dsp.workspace.toggle_special("btop"))
hl.bind("SUPER + SHIFT + N", hl.dsp.window.move({ workspace = "special:btop" }))

-- Move windows between monitors
hl.bind("ALT + SUPER + Q", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind("ALT + SUPER + E", hl.dsp.workspace.move({ monitor = "-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot
hl.bind("PRINT", hl.dsp.exec_cmd("screenshot.sh"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("screenshot-edit.sh"))

-- Laptop multimedia keys for volume and LCD brightness

-- Ignore `replaceVars`'s error on unconsumed variable
local default_audio = "@" .. "DEFAULT_AUDIO"

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 " .. default_audio .. "_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume " .. default_audio .. "_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute " .. default_audio .. "_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute " .. default_audio .. "_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 1,
	},

	decoration = {
		rounding = 5,
		inactive_opacity = 0.8,

		dim_inactive = true,
		dim_strength = -0.2,

		blur = {
			size = 2,
			passes = 2,
		},
	},
})

-- Curves and animations
hl.curve("easeOutExpo", {
	type = "bezier",
	points = {
		{ 0.16, 1 },
		{ 0.3, 1 },
	},
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 2,
	bezier = "easeOutExpo",
	style = "slide",
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
-- hl.config({
-- 	dwindle = {
-- 		preserve_split = true, -- You probably want this
-- 	},
-- })
--
-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
-- hl.config({
-- 	master = {
-- 		new_status = "master",
-- 	},
-- })
--
-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
-- hl.config({
-- 	scrolling = {
-- 		fullscreen_on_one_column = true,
-- 	},
-- })

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		middle_click_paste = false,
	},
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		sensitivity = -0.88,

		kb_layout = "us,cz,ua,ru",
		kb_variant = ",qwerty,,",
		kb_options = "grp:caps_toggle",
	},
})

hl.device({
	name = "elan0515:00-04f3:3142-touchpad",
	sensitivity = 0,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({ match = { class = "^zen-beta$" }, workspace = "1", scrolling_width = 0.75 })
hl.window_rule({ match = { class = "^equibop$" }, workspace = "3 silent" })
hl.window_rule({ match = { title = "^Steam$" }, workspace = "4 silent", scrolling_width = 0.95 })
hl.window_rule({ match = { class = "^steam$" }, workspace = "4 silent", scrolling_width = 0.95 })
hl.window_rule({ match = { class = "^heroic$" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "^Minecraft$" }, workspace = "4 silent" })
hl.window_rule({
	name = "dbeaver",
	match = { class = "^DBeaver$" },
	workspace = "5 silent",
	no_initial_focus = true,
})

hl.window_rule({
	name = "Steam Friends List",
	match = {
		class = "^steam$",
		title = "^Список друзів$",
	},
	workspace = "4 silent",
	float = true,
	center = true,
	size = "383, 691",
})

hl.window_rule({
	name = "Calculator",
	match = { class = "^org.gnome.Calculator$" },
	float = true,
	center = true,
	size = "383, 691",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

-- Workspace rules
hl.workspace_rule({ workspace = "1", layout = "scrolling" })
hl.workspace_rule({ workspace = "3", layout = "scrolling" })
hl.workspace_rule({ workspace = "4", layout = "scrolling" })
hl.workspace_rule({ workspace = "5", layout = "scrolling" })
hl.workspace_rule({ workspace = "6", layout = "scrolling" })
