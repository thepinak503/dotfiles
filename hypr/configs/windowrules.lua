-- Window matching filters and rules
-- Group tags matching
hl.window_rule({ match = { class = "(firefox|google-chrome|chromium|brave|thorium|zen-beta)" }, tag = "+browser" })
hl.window_rule({ match = { class = "(kitty|alacritty|foot)" }, tag = "+terminal" })
hl.window_rule({ match = { class = "(code-oss|code|zed|jetbrains-.*)" }, tag = "+projects" })
hl.window_rule({ match = { class = "(discord|ferdium|whatsapp|telegram|element|webcord)" }, tag = "+im" })
hl.window_rule({ match = { class = "(thunar|nautilus|pcmanfm|nemo)" }, tag = "+filemanager" })
hl.window_rule({ match = { class = "(mpv|vlc|audacious)" }, tag = "+media" })
hl.window_rule({ match = { class = "(pavucontrol|blueman-manager|nm-connection-editor|gnome-control-center|qt5ct|qt6ct|nwg-look)" }, tag = "+settings" })

-- Opacity & Behavior rules based on tags
hl.window_rule({ match = { tag = "terminal" }, opacity = "0.92 0.80" })
hl.window_rule({ match = { tag = "browser" }, opacity = "0.98 0.85" })
hl.window_rule({ match = { tag = "projects" }, opacity = "0.95 0.82" })
hl.window_rule({ match = { tag = "im" }, opacity = "0.95 0.86" })
hl.window_rule({ match = { tag = "filemanager" }, opacity = "0.93 0.80" })
hl.window_rule({ match = { tag = "media" }, opacity = "0.95 0.82" })
hl.window_rule({ match = { tag = "settings" }, float = true, center = true, size = { "60%", "60%" } })

-- Specific window rules
hl.window_rule({ match = { class = "pavucontrol" }, float = true, center = true, size = { "60%", "60%" } })
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "xdg-desktop-portal" }, float = true })
hl.window_rule({
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin = true,
    opacity = "0.95 0.75",
    size = { "30%", "30%" },
    move = { "72%", "7%" }
})
hl.window_rule({ match = { class = "rofi" }, no_shadow = true })
hl.window_rule({ match = { class = "Rofi" }, no_shadow = true })
hl.window_rule({
    match = { class = "xwaylandvideobridge" },
    opacity = "0.0 0.0", -- active/inactive override
    no_anim = true,
    max_size = { 1, 1 }
})
hl.window_rule({ match = { class = "waybar" }, no_shadow = true })
hl.window_rule({ match = { class = "Waybar" }, no_shadow = true })

-- Idle inhibit
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })
