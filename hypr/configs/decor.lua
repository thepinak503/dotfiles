-- =============================================================================
-- DECORATION, COLORS, BORDERS, SHADOWS & BLUR
-- =============================================================================
-- This file controls window decorations, borders, shadows, blur effects,
-- gaps, rounding, and overall window appearance in Hyprland.
-- =============================================================================

hl.config({
    general = {
        -- =====================================================================
        -- GAPS & BORDERS
        -- =====================================================================
        gaps_in     = 5,          -- Inner gaps (between windows)
        gaps_out    = 8,          -- Outer gaps (between windows and screen edges)
        border_size = 2,          -- Border width in pixels
        col = {
            -- Animated gradient border (active window)
            active_border   = { colors = {theme.accent, theme.accent3, theme.accent2}, angle = 45 },
            inactive_border = theme.bg_alt,  -- Solid border for inactive windows
            -- Alternative gradient borders:
            -- active_border = { colors = {"rgba(88c0d0ee)", "rgba(81a1c1ee)", "rgba(8fbcbbee)"}, angle = 45 },
        },
        layout = "dwindle",       -- Default layout: "dwindle" or "master"
        resize_corner = 2,        -- Corner to use for resize cursor (0=none, 1=bottom-right, 2=all)
        no_border_on_floating = false, -- Show borders on floating windows too
        gaps_workspaces_only = false,  -- Apply gaps only within workspaces (not monitor edges)
    },

    cursor = {
        -- Hide cursor when inactive (seconds, 0 = never)
        inactive_timeout = 3,
        -- Zoom factor when cursor is at screen edge (1.0 = no zoom)
        zoom_factor = 1.0,
        -- Enable/disable cursor warping (teleporting cursor to focused window center)
        no_warps = false,
        -- Warp cursor to the center of the focused window on workspace change
        warp_on_change_workspace = 0,  -- 0=off, 1=on
    },

    decoration = {
        -- =====================================================================
        -- WINDOW ROUNDING & OPACITY
        -- =====================================================================
        rounding           = 10,    -- Window corner rounding in pixels
        active_opacity     = 1.0,   -- Opacity of active (focused) window
        inactive_opacity   = 0.90,  -- Opacity of inactive windows
        fullscreen_opacity = 1.0,   -- Opacity when fullscreen (always 1.0)

        -- =====================================================================
        -- DROP SHADOWS
        -- =====================================================================
        shadow = {
            enabled        = true,
            range          = 16,       -- Shadow blur range (pixels)
            render_power   = 4,        -- Shadow render quality (higher = smoother)
            color          = "rgba(0,0,0,0.55)",       -- Active shadow color
            color_inactive = "rgba(0,0,0,0.35)",       -- Inactive shadow color
            offset         = { 3, 5 }, -- Shadow offset (x, y)
            scale          = 0.97,     -- Shadow scale (1.0 = no scaling)
            ignore_window  = true,     -- Ignore window for shadow calculation
        },

        -- =====================================================================
        -- BACKGROUND BLUR
        -- =====================================================================
        blur = {
            enabled            = true,
            size               = 10,          -- Blur strength
            passes             = 3,           -- Blur quality (1-4, higher = slower but smoother)
            ignore_opacity     = false,       -- Blur behind transparent windows
            xray               = false,       -- X-ray mode (blur behind window content only)
            noise              = 0.01,        -- Blur noise (adds texture, 0.0-1.0)
            contrast           = 0.8,         -- Blur contrast adjustment
            brightness         = 1.0,         -- Blur brightness
            popups             = true,        -- Blur behind popup windows
            popups_ignorealpha = 0.6,         -- Alpha threshold for popup blur
            popups_blur_new = true,           -- Apply blur to newly created popups
            new_optimizations  = true,        -- Use new blur optimizations
        },

        -- =====================================================================
        -- WINDOW DIM
        -- =====================================================================
        dim_inactive = false,         -- Dim inactive windows
        dim_strength = 0.0,           -- Dim strength (0.0-1.0)
        dim_special  = 0.15,          -- Dim strength for special workspace
    },
})

-- =============================================================================
-- GAP SIZE REFERENCE
-- =============================================================================
--   Minimal:      gaps_in=2, gaps_out=4
--   Default:      gaps_in=5, gaps_out=8
--   Comfortable:  gaps_in=8, gaps_out=12
--   Spacious:     gaps_in=10, gaps_out=16
--   Borderless:   gaps_in=0, gaps_out=0

-- =============================================================================
-- BLUR QUALITY REFERENCE
-- =============================================================================
--   Off:            passes=0, size=0
--   Low:            passes=2, size=5
--   Medium:         passes=3, size=8
--   High:           passes=4, size=12
--   Ultra-high:     passes=4, size=20
