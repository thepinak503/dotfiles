-- =============================================================================
-- HYPRLAND — MAIN LUA CONFIGURATION ENTRYPOINT
-- =============================================================================
-- This is the primary configuration file loaded by Hyprland at startup.
-- It requires all modular configuration files in the correct order.
--
-- Config directory: ~/.config/hypr/hyprland.conf → hyprland.lua
-- Override loading: hyprctl reload
-- Config syntax check: hyprctl configwarnings
-- =============================================================================

-- =============================================================================
-- THEME COLORS
-- =============================================================================
-- Must be loaded first so all other configs can reference theme variables

pcall(require, "configs/theme")

-- =============================================================================
-- ENVIRONMENT VARIABLES
-- =============================================================================
-- GPU drivers, Wayland backends, app-specific settings.
-- These are typically set by the set-env script in autostart.
-- Use pcall to gracefully handle missing env file.

-- Synchronously generate env variables before loading
local home = os.getenv("HOME")
if home then
    os.execute(home .. "/.local/share/dotfiles/hypr/scripts/set-env > /dev/null 2>&1")
end

pcall(require, "configs/env")

-- =============================================================================
-- MONITOR SETUP
-- =============================================================================
-- Display layout, resolution, refresh rate, scaling, workspace assignments

pcall(require, "configs/monitors")

-- =============================================================================
-- INPUT CONFIGURATION
-- =============================================================================
-- Keyboard layout, mouse/touchpad settings, gestures

pcall(require, "configs/input")

-- =============================================================================
-- DECORATIONS
-- =============================================================================
-- Borders, shadows, blur, gaps, window rounding, opacity

pcall(require, "configs/decor")

-- =============================================================================
-- ANIMATIONS
-- =============================================================================
-- Window open/close animations, workspace transitions, borders, fades

pcall(require, "configs/animations")

-- =============================================================================
-- WINDOW RULES
-- =============================================================================
-- Per-application window behavior: floating, opacity, sizing, tiling rules

pcall(require, "configs/windowrules")

-- =============================================================================
-- WORKSPACE & MISC SETTINGS
-- =============================================================================
-- Dwindle/Master layout, binds, misc, debug, xwayland

pcall(require, "configs/workspaces")

-- =============================================================================
-- KEYBINDINGS
-- =============================================================================
-- All keyboard shortcuts organized by category

pcall(require, "configs/keybinds")

-- =============================================================================
-- AUTOSTART
-- =============================================================================
-- Applications and services to launch on startup

pcall(require, "configs/autostart")

-- =============================================================================
-- PER-DEVICE CONFIGURATION
-- =============================================================================
-- Input settings for specific devices (touchpads, keyboards, mice)

pcall(require, "configs/devices")

-- =============================================================================
-- LOAD ORDER NOTES
-- =============================================================================
-- The require order matters!
-- 1. theme — needed by decor, animations, keybinds
-- 2. env — needed before any app starts
-- 3. monitors — must be first for workspace assignments
-- 4. input — basic input setup
-- 5. decor — window appearance
-- 6. animations — animation settings
-- 7. windowrules — rules reference animations + decor
-- 8. workspaces — layout and misc settings
-- 9. keybinds — expects all above to be loaded
-- 10. autostart — starts apps after everything is configured
-- 11. devices — overrides input for specific devices

-- =============================================================================
-- TROUBLESHOOTING
-- =============================================================================
-- If you get errors on startup:
--   1. Check the log: journalctl --user -xe -u hyprland
--   2. Run hyprctl configwarnings for config issues
--   3. Try loading the default config: mv hyprland.conf hyprland.conf.bak
--   4. Check for missing theme variables in theme.lua
--   5. Ensure all paths in autostart.lua point to valid executables
-- =============================================================================
