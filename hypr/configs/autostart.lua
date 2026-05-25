-- =============================================================================
-- AUTOSTART APPLICATIONS
-- =============================================================================
-- Applications and services to launch when Hyprland starts.
-- Runs in order, but most apps launch asynchronously.
-- =============================================================================

local home = os.getenv("HOME")
local dots = home .. "/.local/share/dotfiles"

hl.on("hyprland.start", function ()
    -- =========================================================================
    -- NOTIFICATIONS & BARS
    -- =========================================================================

    -- Notification daemon (mpris, dunst replacement)
    hl.exec_cmd("swaync")

    -- Top status bar (main bar)
    hl.exec_cmd("waybar")

    -- Bottom status bar (secondary bar with system tray)
    hl.exec_cmd("waybar -c " .. dots .. "/waybar/config-bottom.jsonc -s " .. dots .. "/waybar/style.css")

    -- =========================================================================
    -- WALLPAPER & IDLE
    -- =========================================================================

    -- Wallpaper daemon
    hl.exec_cmd("hyprpaper")

    -- Fetch and set wallpaper after a short delay (wait for hyprpaper to init)
    hl.exec_cmd("sleep 2 && " .. dots .. "/hypr/scripts/wallpaper-fetch --quiet")

    -- Idle management daemon (locks screen, suspends, etc.)
    hl.exec_cmd("hypridle")

    -- =========================================================================
    -- ON-SCREEN DISPLAY (OSD)
    -- =========================================================================

    -- Volume, brightness, and other OSD indicators
    hl.exec_cmd("swayosd-server")

    -- =========================================================================
    -- AUTHENTICATION AGENTS
    -- =========================================================================

    -- Polkit authentication agent (for admin dialogs)
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Alternative: polkit-kde-agent
    -- hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

    -- =========================================================================
    -- DESKTOP PORTALS
    -- =========================================================================

    -- XDG Desktop Portal for Hyprland (file picker, screen capture, etc.)
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")

    -- Generic XDG Desktop Portal (fallback for non-Hyprland portals)
    -- hl.exec_cmd("/usr/lib/xdg-desktop-portal")

    -- =========================================================================
    -- SYSTEM TRAY APPLICATIONS
    -- =========================================================================

    -- Network Manager applet (WiFi, VPN, etc.)
    hl.exec_cmd("nm-applet --indicator")

    -- Bluetooth applet
    hl.exec_cmd("blueman-applet")

    -- =========================================================================
    -- SESSION & KEYRING
    -- =========================================================================

    -- Update environment variables for systemd services
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- GNOME Keyring daemon (SSH keys, GPG, secrets)
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    -- =========================================================================
    -- ENVIRONMENT SETUP
    -- =========================================================================

    -- Set up GPU and environment variables (auto-detected)
    hl.exec_cmd(dots .. "/hypr/scripts/set-env > /dev/null 2>&1")
end)

-- =============================================================================
-- COMPOSITOR EVENTS
-- =============================================================================

-- Reload all UI when theme changes
hl.on("theme.change", function ()
    hl.exec_cmd(dots .. "/hypr/scripts/waybar-reload")
    hl.exec_cmd(dots .. "/hypr/scripts/refresh")
end)

-- =============================================================================
-- NOTES
-- =============================================================================
-- To debug autostart issues:
--   1. Check Hyprland logs: cat /tmp/hypr/$(ls /tmp/hypr/)/hyprland.log
--   2. Run commands manually in terminal to verify they work
--   3. Check for missing executables: which <command>
--   4. Add sleep delays between dependent services
-- =============================================================================
