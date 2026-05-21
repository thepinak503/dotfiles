-- Keybindings configuration
local mainMod = "SUPER"

-- Launch Applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("rofi -show drun -config /home/pinak/.config/rofi/config-full.rasi"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("kitty btop"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("rofi -show window -config /home/pinak/.config/rofi/config-full.rasi"))
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
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.group.next())
hl.bind(mainMod .. " + CTRL + Tab", hl.dsp.group.prev())
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.lock({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + G", function() hl.dispatch("moveintogroup", "forward") end)
hl.bind(mainMod .. " + CTRL + SHIFT + G", function() hl.dispatch("moveoutofgroup") end)

-- Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
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

-- Help
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/keyhints"))

-- Mouse actions
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Active window resize (keyboard)
hl.bind(mainMod .. " + left",  function() hl.dispatch("resizeactive", "-30 0") end)
hl.bind(mainMod .. " + right", function() hl.dispatch("resizeactive", "30 0") end)
hl.bind(mainMod .. " + up",    function() hl.dispatch("resizeactive", "0 -30") end)
hl.bind(mainMod .. " + down",  function() hl.dispatch("resizeactive", "0 30") end)

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

-- Screenshots
hl.bind("Print",         hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("CTRL + Print",  hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + CTRL + S",  hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Screen Recording
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/screenrecord"))

-- Layout
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/changeLayout"))

-- Touchpad Toggle
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/touchpad"))

-- Color Picker
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Game Mode
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/gamemode"))

-- Keyhints
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/keyhints"))

-- Media Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/volume --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/volume --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/volume --toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/brightness --inc"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/brightness --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Lock & Logout
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("hyprctl dispatch exit"))

-- Reload Config
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Wallpapers
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.local/share/dotfiles/hypr/scripts/wallpaper-fetch"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd('hyprctl hyprpaper wallpaper ",$(find /home/pinak/.local/share/dotfiles/wallpapers -type f | shuf -n 1)"'))

-- Clipboard
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Notifications
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Toggle Waybar hidden
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
