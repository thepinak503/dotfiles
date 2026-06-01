-- =============================================================================
-- WINDOW RULES CONFIGURATION
-- =============================================================================
-- Rules for matching windows by class, title, or other properties.
-- Rules control window behavior: float, opacity, size, position, blur, etc.
-- =============================================================================

-- =============================================================================
-- TAG-BASED CATEGORIZATION
-- =============================================================================
-- Tag windows by their application class for group-level rules.

-- Browsers
hl.window_rule({ match = { class = "(firefox|google-chrome|chromium|brave|thorium|zen-beta)" }, tag = "+browser" })

-- Terminals
hl.window_rule({ match = { class = "(kitty|alacritty|foot|wezterm|ghostty)" }, tag = "+terminal" })

-- Development / IDEs
hl.window_rule({ match = { class = "(code-oss|code|zed|jetbrains-.*|idea|pycharm|goland|clion|webstorm|phpstorm|rider)" }, tag = "+projects" })

-- Communication / Instant Messaging
hl.window_rule({ match = { class = "(discord|ferdium|whatsapp|telegram|element|webcord|signal|slack|teams|zoom|skype)" }, tag = "+im" })

-- File Managers
hl.window_rule({ match = { class = "(thunar|nautilus|pcmanfm|nemo|dolphin|ranger|lf)" }, tag = "+filemanager" })

-- Media Players
hl.window_rule({ match = { class = "(mpv|vlc|audacious|spotify|strawberry)" }, tag = "+media" })

-- System Settings & Control Panels
hl.window_rule({ match = { class = "(pavucontrol|blueman-manager|nm-connection-editor|gnome-control-center|qt5ct|qt6ct|nwg-look)" }, tag = "+settings" })

-- =============================================================================
-- TAG-BASED OPACITY & BEHAVIOR
-- =============================================================================

-- Terminal windows — lower opacity for better background visibility
hl.window_rule({ match = { tag = "terminal" }, opacity = "0.80 0.60" })

-- Browser windows
hl.window_rule({ match = { tag = "browser" }, opacity = "0.82 0.65" })

-- IDE / Dev tools
hl.window_rule({ match = { tag = "projects" }, opacity = "0.80 0.62" })

-- IM / Chat apps
hl.window_rule({ match = { tag = "im" }, opacity = "0.82 0.68" })

-- File managers
hl.window_rule({ match = { tag = "filemanager" }, opacity = "0.80 0.60" })

-- Media players
hl.window_rule({ match = { tag = "media" }, opacity = "0.82 0.62" })

-- Settings — float + center by default
hl.window_rule({ match = { tag = "settings" }, float = true, center = true, size = { "60%", "60%" } })

-- =============================================================================
-- SPECIFIC APPLICATION RULES
-- =============================================================================

-- Audio control panel: float + center + fixed size
hl.window_rule({ match = { class = "pavucontrol" }, float = true, center = true, size = { "60%", "60%" } })

-- Bluetooth manager: float
hl.window_rule({ match = { class = "blueman-manager" }, float = true })

-- Portal: float (prevents tiling issues)
hl.window_rule({ match = { class = "xdg-desktop-portal" }, float = true })

-- Picture-in-Picture: float + pin to corner
hl.window_rule({
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin = true,
    opacity = "0.95 0.75",
    size = { "30%", "30%" },
    move = { "72%", "7%" }
})

-- Picture-in-Picture for Firefox
hl.window_rule({
    match = { title = "^(Picture-in-Picture|pip)$" },
    float = true,
    pin = true,
    opacity = "0.95 0.75",
    size = { "30%", "30%" },
    move = { "72%", "7%" }
})

-- Rofi: no shadow (clean appearance)
hl.window_rule({ match = { class = "rofi" }, no_shadow = true })
hl.window_rule({ match = { class = "Rofi" }, no_shadow = true })

-- XWayland video bridge: hide completely
hl.window_rule({
    match = { class = "xwaylandvideobridge" },
    opacity = "0.0 0.0",
    no_anim = true,
    max_size = { 1, 1 }
})

-- Waybar: no shadow
hl.window_rule({ match = { class = "waybar" }, no_shadow = true })
hl.window_rule({ match = { class = "Waybar" }, no_shadow = true })

-- =============================================================================
-- FULLSCREEN INHIBITION
-- =============================================================================
-- Prevent idle when fullscreen apps are running

hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- Media apps should also inhibit idle
hl.window_rule({ match = { class = "(mpv|vlc|spotify)" }, idle_inhibit = "always" })

-- =============================================================================
-- AUTHENTICATION & SECURITY (CINEMATIC DIMMING)
-- =============================================================================
-- Dim the rest of the screen when a password prompt appears for ultimate focus
hl.window_rule({ match = { class = "polkit-gnome-authentication-agent-1" }, float = true, center = true })
hl.window_rule({ match = { class = "org.kde.polkit-kde-authentication-agent-1" }, float = true, center = true })

-- =============================================================================
-- DIALOGS, FILE PICKERS, & POPUPS
-- =============================================================================
hl.window_rule({ match = { title = ".*(Open|Save|Choose|Select|Upload)( File| Folder| As)?.*" }, float = true, center = true, size = { "60%", "60%" } })
hl.window_rule({ match = { title = ".*(Confirm|Warning|Error|Alert|Message|Properties|Settings).*" }, float = true, center = true })

-- =============================================================================
-- ADDITIONAL APPLICATION RULES
-- =============================================================================

-- Floating by default
hl.window_rule({ match = { class = "flameshot" }, float = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true, size = { "30%", "40%" } })
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, float = false })
hl.window_rule({ match = { class = "Lxappearance" }, float = true })
hl.window_rule({ match = { class = "imv" }, float = true, center = true, keep_aspect_ratio = true })
hl.window_rule({ match = { class = "mpv" }, float = true, center = true, keep_aspect_ratio = true, size = { "60%", "60%" } })
hl.window_rule({ match = { class = "qt5ct" }, float = true })
hl.window_rule({ match = { class = "qt6ct" }, float = true })
hl.window_rule({ match = { class = "nwg-look" }, float = true })
hl.window_rule({ match = { class = "Oblogout" }, float = true })

-- Center floating windows
hl.window_rule({ match = { class = "pavucontrol" }, center = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, center = true })
hl.window_rule({ match = { class = "blueman-manager" }, center = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, center = true })
hl.window_rule({ match = { class = "Lxappearance" }, center = true })
hl.window_rule({ match = { class = "qt5ct" }, center = true })
hl.window_rule({ match = { class = "qt6ct" }, center = true })
hl.window_rule({ match = { class = "nwg-look" }, center = true })

-- Games & Tearing Optimization
hl.window_rule({ match = { class = "^steam$" }, tag = "+games" })
hl.window_rule({ match = { class = "^steam_app_.*" }, tag = "+games" })
hl.window_rule({ match = { class = "^gamescope$" }, tag = "+games", fullscreen = true })
hl.window_rule({ match = { class = "^heroic$" }, tag = "+games" })
hl.window_rule({ match = { class = "^lutris$" }, tag = "+games" })
hl.window_rule({ match = { class = "^minetest$" }, tag = "+games" })
hl.window_rule({ match = { class = "^Minecraft.*$" }, tag = "+games" })

-- Utilities & Popups
hl.window_rule({ match = { class = "^1Password$" }, float = true, center = true })
hl.window_rule({ match = { class = "^org.keepassxc.KeePassXC$" }, float = true, center = true })
hl.window_rule({ match = { class = "^Bitwarden$" }, float = true, center = true })
hl.window_rule({ match = { class = "^org.gnome.Calculator$" }, float = true, size = { "25%", "35%" } })
hl.window_rule({ match = { class = "^gnome-system-monitor$" }, float = true, size = { "50%", "60%" } })
hl.window_rule({ match = { class = "^file-roller$" }, float = true, center = true })
hl.window_rule({ match = { class = "^org.gnome.FileRoller$" }, float = true, center = true })
hl.window_rule({ match = { class = "^xdg-desktop-portal.*" }, float = true, center = true })
hl.window_rule({ match = { class = "^polkit-kde-authentication-agent-1$" }, float = true })
hl.window_rule({ match = { class = "^polkit-gnome-authentication-agent-1$" }, float = true })

-- Developer Tools
hl.window_rule({ match = { class = "^Godot$" }, float = false })
hl.window_rule({ match = { class = "^Unity$" }, float = false })
hl.window_rule({ match = { class = "^blender$" }, float = false })
hl.window_rule({ match = { title = "Developer Tools.*" }, float = true, center = true, size = { "70%", "70%" } })
hl.window_rule({ match = { class = "^postman$" }, opacity = "0.95 0.90" })

-- Picture-in-Picture & Media enhancements
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true, pin = true, opacity = "1.0 0.8", size = { "25%", "25%" }, move = { "74%", "4%" }, keep_aspect_ratio = true })
hl.window_rule({ match = { title = "^(Picture in picture)$" }, float = true, pin = true, opacity = "1.0 0.8", size = { "25%", "25%" }, move = { "74%", "4%" }, keep_aspect_ratio = true })
hl.window_rule({ match = { class = "^imv$" }, float = true, center = true, keep_aspect_ratio = true })
hl.window_rule({ match = { class = "^mpv$" }, float = true, center = true, keep_aspect_ratio = true, size = { "60%", "60%" } })
hl.window_rule({ match = { class = "^Spotify$" }, opacity = "0.85 0.75" })

-- Messaging overlays
hl.window_rule({ match = { class = "^telegram-desktop$", title = "^Media viewer$" }, float = true, center = true, fullscreen = true })
hl.window_rule({ match = { class = "^discord$", title = "^Discord Updater$" }, float = true, center = true })
hl.window_rule({ match = { class = "^slack$", title = "^Slack - Huddle$" }, float = true, pin = true })

-- File managers behavior
hl.window_rule({ match = { class = "^org.gnome.Nautilus$" }, float = false })
hl.window_rule({ match = { class = "^thunar$" }, float = false })
hl.window_rule({ match = { class = "^yazi$" }, float = false })
hl.window_rule({ match = { class = "^nemo$" }, float = false })

-- Fixes for sharing screens on Wayland
hl.window_rule({ match = { class = "^xwaylandvideobridge$" }, opacity = "0.0 0.0", no_anim = true, max_size = { 1, 1 }, no_shadow = true, no_blur = true, no_focus = true })

-- =============================================================================
-- BORDER ANIMATION OVERRIDES
-- =============================================================================
-- Special windows that should have different border behavior

hl.window_rule({ match = { class = "firefox" }, tag = "+browser" })
hl.window_rule({ match = { class = "google-chrome" }, tag = "+browser" })
hl.window_rule({ match = { class = "kitty" }, tag = "+terminal" })

-- =============================================================================
-- WINDOW RULE REFERENCE
-- =============================================================================
-- Available match fields:
--   class    = WM_CLASS (app identifier, run 'hyprctl clients' to find)
--   title    = Window title
--   tag      = Window tag (assigned via tag rule)
--   fullscreen = Match fullscreen windows
--   floating = Match floating windows
--
-- Available rule actions:
--   float         = Force floating (true/false)
--   center        = Center on screen (true/false)
--   size          = Set size {"W%", "H%"} or {"Wpx", "Hpx"}
--   move          = Set position {"X", "Y"}
--   pin           = Always on top (true/false)
--   opacity       = "active inactive"
--   no_shadow     = Disable shadows (true/false)
--   no_anim       = Disable animations (true/false)
--   max_size      = Maximum window size
--   min_size      = Minimum window size
--   idle_inhibit  = Inhibit idle: "always", "fullscreen", "never"
--   no_blur       = Disable blur behind (true/false)
--   fullscreen    = Force fullscreen (1=normal, 2=fullscreen, 0=toggle)
--   (focus-related fields removed in v0.55)
--   force_isolation = Force window isolation (true/false)
--   workspace     = Pin to workspace: "unset", "silent", "empty"
--   monitor       = Pin to monitor by name
--   keep_aspect_ratio = Keep aspect ratio (true/false)
--   border       = Override border size
--   bordercolor  = Override border color
--   dimaround    = Dim the area around the window (true/false)
--   group         = Force window into group
--   maximize     = Maximize on creation (true/false)
--   minimize     = Minimize on creation (true/false)
--   rounding     = Override corner rounding
--   tag          = Assign a tag for group rules
-- =============================================================================
