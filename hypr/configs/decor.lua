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
        -- no_border_on_floating removed in v0.55 (always shows borders)
        -- gaps_workspaces_only removed in v0.55 (gaps always apply within workspaces)
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
        rounding           = 12,    -- Window corner rounding in pixels (slightly softer)
        active_opacity     = 1.0,   -- Opacity of active (focused) window
        inactive_opacity   = 0.90,  -- Opacity of inactive windows
        fullscreen_opacity = 1.0,   -- Opacity when fullscreen (always 1.0)

        -- =====================================================================
        -- DROP SHADOWS
        -- =====================================================================
        shadow = {
            enabled        = true,
            range          = 30,       -- High shadow blur range
            render_power   = 3,        -- Balanced shadow render quality
            color          = "rgba(0,0,0,0.70)",       -- Deep active shadow
            color_inactive = "rgba(0,0,0,0.45)",       -- Deep inactive shadow
            offset         = { 0, 8 }, -- Floating shadow offset (straight down)
            scale          = 0.97,     -- Shadow scale (1.0 = no scaling)
        },

        -- =====================================================================
        -- BACKGROUND BLUR
        -- =====================================================================
        blur = {
            enabled            = true,
            size               = 12,          -- Ultimate blur strength
            passes             = 4,           -- Ultra-high blur quality (4 passes for butter smooth glass)
            ignore_opacity     = true,        -- True enables premium glassmorphism behind transparent apps!
            xray               = true,        -- X-ray mode for layered transparency depth
            noise              = 0.0117,      -- Very subtle noise
            contrast           = 0.8916,      -- Higher contrast for punchy glass
            brightness         = 0.8172,      -- Slightly darkened behind blur
            vibrancy           = 0.1696,      -- JaKooLit-style ultra glassmorphism
            vibrancy_darkness  = 0.0,
            popups             = true,        -- Blur behind popup windows
            popups_ignorealpha = 0.2,         -- Alpha threshold for popup blur
        },

        -- =====================================================================
        -- WINDOW DIM
        -- =====================================================================
        dim_inactive = true,          -- Dim inactive windows for focus hierarchy
        dim_strength = 0.1,           -- Subtle dim strength (0.0-1.0)
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
