-- =============================================================================
-- MONITOR CONFIGURATION
-- =============================================================================
-- This file defines monitor layouts, resolutions, refresh rates, scaling,
-- and workspace assignments. Hyprland automatically detects monitors,
-- but explicit configuration gives you full control.
--
-- Monitor identification:
--   Run 'hyprctl monitors' to list connected monitors with their names.
--   Common names: eDP-1 (laptop), HDMI-A-1, DP-1, DP-2, DP-3
--
-- Position format: "XxY" where X and Y are pixel offsets from top-left.
-- A monitor at "1920x0" is to the right of a 1920px-wide primary monitor.
--
-- Workspace assignment: assign workspaces to specific monitors so they
-- always appear on the correct display.
-- =============================================================================

-- =============================================================================
-- PRIMARY LAPTOPS DISPLAY
-- =============================================================================
-- Typically the built-in laptop panel. Use 'hyprctl monitors' to confirm.
-- If you want auto-detection, leave output empty ("").

hl.monitor({
    output   = "eDP-1",          -- Laptop built-in display
    mode     = "preferred",       -- Use the panel's native resolution (e.g., 1920x1080@60)
    position = "0x0",            -- Top-left corner (primary monitor)
    scale    = 1.0,              -- 1.0 = no scaling, 1.5 = fractional, 2.0 = HiDPI
    enable   = true,             -- Enable this monitor
    mirror   = nil,              -- Mirror another monitor's output (e.g., "DP-1")
    workspace = "1",             -- Default workspace on this monitor
    autostart = true,            -- Apply configuration automatically
})

-- =============================================================================
-- EXTERNAL MONITOR — HDMI
-- =============================================================================
-- Uncomment and customize for your external HDMI monitor.
-- Use 'hyprctl monitors' to get the exact output name.

-- hl.monitor({
--     output   = "HDMI-A-1",
--     mode     = "1920x1080@144",      -- 1080p at 144Hz
--     position = "1920x0",             -- To the right of laptop display
--     scale    = 1.0,
--     enable   = true,
--     workspace = "3",                 -- Workspace 3 starts on this monitor
-- })

-- =============================================================================
-- EXTERNAL MONITOR — DisplayPort
-- =============================================================================
-- For desktop setups or docks with DisplayPort connections.

-- hl.monitor({
--     output   = "DP-1",
--     mode     = "2560x1440@165",      -- 1440p at 165Hz
--     position = "3840x0",             -- To the right of HDMI monitor
--     scale    = 1.0,
--     enable   = true,
--     workspace = "5",
-- })

-- =============================================================================
-- EXTERNAL MONITOR — USB-C / Thunderbolt
-- =============================================================================

-- hl.monitor({
--     output   = "DP-2",
--     mode     = "3440x1440@100",      -- Ultrawide at 100Hz
--     position = "1920x0",
--     scale    = 1.0,
--     enable   = true,
--     workspace = "7",
-- })

-- =============================================================================
-- WORKSPACE-TO-MONITOR MAPPING
-- =============================================================================
-- Explicitly assign workspaces to monitors. This ensures that when you
-- switch to workspace 3, it always appears on the correct display.
-- Format: hl.workspace(workspace_id, monitor_name)

hl.workspace("1", "eDP-1")
hl.workspace("2", "eDP-1")
-- hl.workspace("3", "HDMI-A-1")
-- hl.workspace("4", "HDMI-A-1")
-- hl.workspace("5", "DP-1")
-- hl.workspace("6", "DP-1")
-- hl.workspace("7", "DP-2")
-- hl.workspace("8", "DP-2")
-- hl.workspace("9", "eDP-1")
-- hl.workspace("10", "eDP-1")

-- =============================================================================
-- DISABLED MONITORS
-- =============================================================================
-- Set enable = false to disable a monitor. Useful for scenarios like
-- closing a laptop lid while docked.

-- hl.monitor({
--     output   = "eDP-1",
--     enable   = false,
-- })

-- =============================================================================
-- VRR (VARIABLE REFRESH RATE) PER MONITOR
-- =============================================================================
-- Enable adaptive sync / VRR on a per-monitor basis.
-- Requires AMD or Intel GPU with VRR support.

-- hl.monitor({
--     output   = "HDMI-A-1",
--     vrr      = true,                  -- Enable FreeSync/G-Sync
-- })

-- =============================================================================
-- CURSOR CONFIGURATION
-- =============================================================================

-- Set a global cursor theme and size
hl.env("XCURSOR_THEME", "Nordzy-cursors")
hl.env("XCURSOR_SIZE", "24")
