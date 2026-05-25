-- =============================================================================
-- SMOOTH ANIMATIONS (SLOW & ELEGANT)
-- =============================================================================
-- Slow, fluid animations for users who prefer visual polish over speed.
-- Best on systems with dedicated GPUs for smooth rendering.
-- Speed: 3-5 (slow), maximum visual feedback.
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
-- Custom easing curves tuned for slower, more pronounced motion.
-- Each curve uses two control points for natural easing.

-- Overshot: gentle bounce at end (for window open)
hl.curve("overshot",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })

-- SmoothOut: long ease-out for graceful dismissals
hl.curve("smoothOut",  { type = "bezier", points = { {0.36, 0},   {0.66, -0.56} } })

-- SmoothIn: slow ease-in for appearing elements
hl.curve("smoothIn",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })

-- SmoothWS: floaty workspace transitions
hl.curve("smoothWS",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })

-- Fluide: smooth, professional motion for borders/fades
hl.curve("fluide",     { type = "bezier", points = { {0.3, 0.0},  {0.3, 1.0} } })

-- =============================================================================
-- WINDOW ANIMATIONS
-- =============================================================================
-- Slower speeds (3-4) for dramatic window transitions

-- Window open: slide in with overshot bounce
hl.animation({ leaf = "windows",          enabled = true, speed = 3,  bezier = "overshot",   style = "slide" })

-- Window close: smooth fade/slide out
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3,  bezier = "smoothOut",  style = "slide" })

-- Window move: subtle follow-through
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 3,  bezier = "overshot",   style = "slide" })

-- =============================================================================
-- BORDER ANIMATIONS
-- =============================================================================

-- Active border color transition (slower for more visible transitions)
hl.animation({ leaf = "border",           enabled = true, speed = 6,  bezier = "default" })

-- Border angle rotation (moderate speed for gradient effect)
hl.animation({ leaf = "borderangle",      enabled = true, speed = 15, bezier = "default", style = "once" })

-- =============================================================================
-- FADE ANIMATIONS
-- =============================================================================

-- Slower fades for smooth opacity transitions
hl.animation({ leaf = "fade",             enabled = true, speed = 3,  bezier = "smoothIn" })

-- Dim overlay fade
hl.animation({ leaf = "fadeDim",          enabled = true, speed = 3,  bezier = "smoothIn" })

-- =============================================================================
-- WORKSPACE ANIMATIONS
-- =============================================================================

-- Workspace slide transitions (slower for visual tracking)
hl.animation({ leaf = "workspaces",       enabled = true, speed = 4,  bezier = "smoothWS", style = "slide" })

-- Special workspace transitions
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4,  bezier = "smoothWS", style = "slide" })

-- =============================================================================
-- USAGE NOTES
-- =============================================================================
-- This animation profile is ideal for:
--   - Demo/recording setups (slow animations look polished on video)
--   - Users who prefer visual feedback over speed
--   - Systems with dedicated GPUs that can handle the extra rendering
--
-- If animations feel too slow, try increasing all speeds by 1-2.
-- If animations feel sluggish, try the "default" animation profile instead.
-- =============================================================================

-- =============================================================================
-- CUSTOMIZATION GUIDE
-- =============================================================================
-- speed = 1 → extremely slow (dramatic)
-- speed = 2 → very slow
-- speed = 3 → slow (this profile's default)
-- speed = 4 → moderate-slow
-- speed = 5 → moderate
--
-- style = "slide"  → windows slide in from edge
-- style = "popin"  → windows scale from center
-- style = "fade"   → windows fade in/out
-- =============================================================================
