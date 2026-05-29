-- =============================================================================
-- KEYBINDINGS CONFIGURATION
-- =============================================================================
-- This file defines all keyboard shortcuts for Hyprland.
-- The SUPER key (Windows/Command key) is the primary modifier.
-- Each section is organized by category for easy navigation.
--
-- Modifier reference:
--   SUPER  = Windows key / Command key
--   ALT    = Alt key
--   CTRL   = Control key
--   SHIFT  = Shift key
--
-- Action reference:
--   hl.bind(key_combo, action, [options])
--   hl.dsp.* = dispatch helper (window management, exec, focus, etc.)
-- =============================================================================

-- Local variables for paths and modifier keys
local home = os.getenv("HOME")
local dots = home .. "/.local/share/dotfiles"
local scripts = dots .. "/hypr/scripts"
local mainMod = "SUPER"
local altMod = "ALT"

-- =============================================================================
-- LAUNCH APPLICATIONS
-- =============================================================================

-- Terminal emulator
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty --working-directory ~/Projects"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(altMod .. " + Space", hl.dsp.exec_cmd("rofi -show drun -config " .. home .. "/.config/rofi/config-full.rasi"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("kitty btop"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("rofi -show window -config " .. home .. "/.config/rofi/config-full.rasi"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofi -show emoji"))

-- Window Management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("wlogout --protocol layer-shell"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))

-- Groups
hl.bind(mainMod .. " + G", function() hl.dispatch("togglegroup", "") end)
hl.bind(mainMod .. " + SHIFT + Tab", function() hl.dispatch("groupnext", "") end)
hl.bind(mainMod .. " + CTRL + Tab", function() hl.dispatch("groupprev", "") end)
hl.bind(mainMod .. " + SHIFT + G", function() hl.dispatch("lockactivegroup", "toggle") end)
hl.bind(mainMod .. " + CTRL + G", function() hl.dispatch("moveintogroup", "forward") end)
hl.bind(mainMod .. " + CTRL + SHIFT + G", function() hl.dispatch("moveoutofgroup") end)

-- Focus
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ direction = "down" }))

-- Swap windows
hl.bind(mainMod .. " + ALT + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))


-- Mouse actions
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Active window resize (keyboard)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- Workspaces 1-9
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Cycle workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + right",  hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + left",   hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + bracketleft",  hl.dsp.window.move({ workspace = "-1" }))

-- Scratchpad
hl.bind(mainMod .. " + grave",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:magic" }))

-- Screenshots (handled by screenshot script)
hl.bind("Print", hl.dsp.exec_cmd(scripts .. "/screenshot --now"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(scripts .. "/screenshot --area"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(scripts .. "/screenshot --window"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scripts .. "/screenshot --area"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd(scripts .. "/screenshot --swappy"))

-- Screen Recording
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(scripts .. "/screenshot --active"))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd(scripts .. "/screenshot"))

-- Layout
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd(scripts .. "/changeLayout"))

-- Touchpad Toggle
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(scripts .. "/touchpad"))

-- Color Picker
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Game Mode
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(scripts .. "/gamemode"))

-- Animations Menu
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(scripts .. "/animations-menu"))

-- Keyhints
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(scripts .. "/keyhints-yad"))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd(scripts .. "/keyhints"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(scripts .. "/settings-menu"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(scripts .. "/refresh"))
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd(scripts .. "/blur-toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(scripts .. "/nightlight"))

-- Media Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scripts .. "/volume --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scripts .. "/volume --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(scripts .. "/volume --toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd(scripts .. "/brightness --inc"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd(scripts .. "/brightness --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Lock & Logout
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("hyprctl dispatch exit"))

-- Reload Config
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Wallpapers
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(scripts .. "/wallpaper-fetch"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(scripts .. "/wallpaper-fetch --next"))

-- Clipboard
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Notifications
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Toggle Waybar hidden
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))

-- Reload Waybar
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(scripts .. "/waybar-reload"))

-- Diagnostics
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("kitty -e " .. scripts .. "/diagreload"))

-- Theme switching
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(dots .. "/themes/theme.sh light"))
hl.bind(mainMod .. " + CTRL + SHIFT + T", hl.dsp.exec_cmd(dots .. "/themes/theme.sh dark"))
