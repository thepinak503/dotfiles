-- =============================================================================
-- DEFAULT ANIMATIONS
-- =============================================================================
-- Balanced animation settings suitable for most users and systems.
-- Speed: 5-6 (medium), good visual feedback without being distracting.
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
-- Custom easing curves for smooth, natural-looking animations.
-- Each curve is defined by two control points (x1,y1, x2,y2).
-- Range: x=[0..1], y=[-1..1] (y can go negative for bounce effects).

-- Overshot: slight bounce at end (for window open/move)
hl.curve("overshot",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })

-- SmoothOut: ease out with subtle overshoot (for close/dismiss)
hl.curve("smoothOut",  { type = "bezier", points = { {0.36, 0},   {0.66, -0.56} } })

-- SmoothIn: gentle ease in (for open/appear animations)
hl.curve("smoothIn",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })

-- SmoothWS: slow ease with float (for workspace transitions)
hl.curve("smoothWS",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })

-- Fluide: smooth, professional motion (for borders, fades)
hl.curve("fluide",     { type = "bezier", points = { {0.3, 0.0},  {0.3, 1.0} } })

-- =============================================================================
-- WINDOW ANIMATIONS
-- =============================================================================

-- Window open/close/move animations
hl.animation({ leaf = "windows",          enabled = true, speed = 6,  bezier = "overshot",   style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 6,  bezier = "smoothOut",  style = "slide" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 6,  bezier = "overshot",   style = "slide" })

-- =============================================================================
-- BORDER ANIMATIONS
-- =============================================================================

-- Active border color transition
hl.animation({ leaf = "border",           enabled = true, speed = 10, bezier = "default" })

-- Border angle rotation (gradient border animation)
hl.animation({ leaf = "borderangle",      enabled = true, speed = 30, bezier = "default", style = "once" })

-- =============================================================================
-- FADE ANIMATIONS
-- =============================================================================

-- General fade/opacity transitions
hl.animation({ leaf = "fade",             enabled = true, speed = 6,  bezier = "smoothIn" })

-- Dim overlay fade (e.g., dim around dialogs)
hl.animation({ leaf = "fadeDim",          enabled = true, speed = 6,  bezier = "smoothIn" })

-- =============================================================================
-- WORKSPACE ANIMATIONS
-- =============================================================================

-- Normal workspace switching
hl.animation({ leaf = "workspaces",       enabled = true, speed = 7,  bezier = "smoothWS", style = "slide" })

-- Special workspace (scratchpad) transitions
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 7,  bezier = "smoothWS", style = "slide" })

-- =============================================================================
-- ANIMATION STYLES REFERENCE
-- =============================================================================
-- Available styles:
--   "slide"  — Windows slide in from direction
--   "popin"  — Windows scale up from center
--   "fade"   — Windows fade in/out
--   "once"   — Animation plays once (for continuous effects like borderangle)
--
-- Available leaf types:
--   windows        — Window open (default style)
--   windowsOut     — Window close
--   windowsMove    — Window move/resize
--   border         — Border color transitions
--   borderangle    — Gradient border rotation
--   fade           — Fade transitions (open/close)
--   fadeDim        — Dim overlay transitions
--   workspaces     — Workspace switching
--   specialWorkspace — Special workspace (scratchpad) transitions
-- =============================================================================

-- =============================================================================
-- SPEED REFERENCE
-- =============================================================================
-- Speed values (higher = faster):
--   1  = Very slow
--   3  = Slow
--   5  = Moderate
--   7  = Fast (default-ish)
--   10 = Very fast
--   20 = Instant (almost)
-- =============================================================================
