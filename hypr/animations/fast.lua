-- =============================================================================
-- FAST ANIMATIONS (SNAPPY & RESPONSIVE)
-- =============================================================================
-- Quick, minimal animations for a snappy, responsive feel.
-- Ideal for gaming, development, or power users who prioritize speed.
-- Speed: 8-12 (fast), minimal visual delay.
-- =============================================================================

-- Enable animations globally
hl.config({
    animations = {
        enabled = true,
    },
})

-- =============================================================================
-- BEZIER CURVES
-- =============================================================================
-- Tighter curves for snappier animation feel.

-- Overshot: quick bounce (for window open)
hl.curve("overshot",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })

-- SmoothOut: fast ease-out (for close/dismiss)
hl.curve("smoothOut",  { type = "bezier", points = { {0.36, 0},   {0.66, -0.56} } })

-- SmoothIn: quick ease-in (for open/appear)
hl.curve("smoothIn",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })

-- SmoothWS: quick workspace transitions
hl.curve("smoothWS",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })

-- Fluide: fast, professional motion
hl.curve("fluide",     { type = "bezier", points = { {0.3, 0.0},  {0.3, 1.0} } })

-- =============================================================================
-- WINDOW ANIMATIONS
-- =============================================================================
-- Fast speeds (7-9) for near-instant window transitions

-- Window open: quick slide in
hl.animation({ leaf = "windows",          enabled = true, speed = 8,  bezier = "overshot",   style = "slide" })

-- Window close: quick fade out
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 8,  bezier = "smoothOut",  style = "slide" })

-- Window move: instant feedback
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 8,  bezier = "overshot",   style = "slide" })

-- =============================================================================
-- BORDER ANIMATIONS
-- =============================================================================

-- Fast border color transitions
hl.animation({ leaf = "border",           enabled = true, speed = 12, bezier = "default" })

-- Fast border angle rotation
hl.animation({ leaf = "borderangle",      enabled = true, speed = 40, bezier = "default", style = "once" })

-- =============================================================================
-- FADE ANIMATIONS
-- =============================================================================

-- Quick fades
hl.animation({ leaf = "fade",             enabled = true, speed = 8,  bezier = "smoothIn" })

-- Quick dim overlay transitions
hl.animation({ leaf = "fadeDim",          enabled = true, speed = 8,  bezier = "smoothIn" })

-- =============================================================================
-- WORKSPACE ANIMATIONS
-- =============================================================================

-- Fast workspace switching
hl.animation({ leaf = "workspaces",       enabled = true, speed = 8,  bezier = "smoothWS", style = "slide" })

-- Fast special workspace transitions
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 8,  bezier = "smoothWS", style = "slide" })

-- =============================================================================
-- USAGE NOTES
-- =============================================================================
-- This animation profile is ideal for:
--   - Gaming (minimal input lag)
--   - Power users who prioritize speed
--   - Systems with integrated GPUs (less rendering overhead)
--   - Users who find standard animations "too slow"
--
-- If you want even faster animations:
--   - Increase all speed values by 2-4
--   - Set bezier to "default" for instant transitions
--   - Disable specific animation leaves: enabled = false
-- =============================================================================

-- =============================================================================
-- SPEED REFERENCE
-- =============================================================================
-- speed = 6  → fast
-- speed = 8  → very fast (this profile's default)
-- speed = 10 → near-instant
-- speed = 15 → almost no visible animation
-- speed = 20 → effectively instant
--
-- style = "slide"  → direction-based slide (fastest)
-- style = "popin"  → scale animation (slightly slower)
-- style = "fade"   → opacity transition (medium)
-- =============================================================================
