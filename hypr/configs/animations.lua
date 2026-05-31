-- =============================================================================
-- ELASTIC / BOUNCY ANIMATIONS (WORLD-CLASS MOTION PHYSICS)
-- =============================================================================
-- High-end, elastic animations designed to feel alive and organic.
-- Features custom spring physics, window pops, and fluid workspace transitions.
-- Speed: Tuned individually per component for optimal weight and responsiveness.
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
-- Custom bezier parameters utilizing values outside [0..1] range for bounce/spring.

-- win_open: Rapid start with a noticeable bouncing snap at the end
hl.curve("win_open",    { type = "bezier", points = { {0.34, 1.56}, {0.64, 1.0} } })

-- win_close: Graceful retraction with a slight pre-close dip
hl.curve("win_close",   { type = "bezier", points = { {0.36, 0.0},  {0.66, -0.56} } })

-- bounce: Pure spring curve for snappy, energetic movements
hl.curve("bounce",      { type = "bezier", points = { {0.85, 0.0},  {0.15, 1.35} } })

-- ws_switch: Slow-fast-slow easing that keeps workspace shifts extremely fluid
hl.curve("ws_switch",   { type = "bezier", points = { {0.68, -0.6}, {0.32, 1.6} } })

-- ease_in_out: Gentle, modern smooth fade transitions
hl.curve("ease_in_out", { type = "bezier", points = { {0.25, 1.0},  {0.5, 1.0} } })

-- md3_decel: Material Design 3 deceleration (The JaKooLit/macOS glassy fade)
hl.curve("md3_decel",   { type = "bezier", points = { {0.05, 0.7},  {0.1, 1.0} } })

-- =============================================================================
-- WINDOW ANIMATIONS
-- =============================================================================

-- Window open: Pop-in scale transition from 80% to 100% with bounce
hl.animation({ leaf = "windows",          enabled = true, speed = 3,  bezier = "win_open",  style = "popin 80%" })

-- Window close: Pop-out scale transition to 80% with quick fade out
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3,  bezier = "win_close", style = "popin 80%" })

-- Window move/resize: Highly responsive spring effect
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 2.5,  bezier = "bounce",    style = "slide" })

-- =============================================================================
-- BORDER ANIMATIONS
-- =============================================================================

-- Active border color transition
hl.animation({ leaf = "border",           enabled = true, speed = 10, bezier = "ease_in_out" })

-- Border gradient rotation angle
hl.animation({ leaf = "borderangle",      enabled = true, speed = 30, bezier = "default" })

-- =============================================================================
-- FADE ANIMATIONS
-- =============================================================================

-- General window fade/opacity
hl.animation({ leaf = "fade",             enabled = true, speed = 3,  bezier = "md3_decel" })

-- Inactive window dimming overlay
hl.animation({ leaf = "fadeDim",          enabled = true, speed = 3,  bezier = "md3_decel" })

-- =============================================================================
-- WORKSPACE ANIMATIONS
-- =============================================================================

-- Workspace slide transitions with bouncing overshoot and return
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3,  bezier = "ws_switch", style = "slide" })

-- Special workspace (scratchpad) transitions
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,  bezier = "ws_switch", style = "slide" })
