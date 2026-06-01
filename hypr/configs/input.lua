-- =============================================================================
-- INPUT CONFIGURATION
-- =============================================================================
-- Keyboard, mouse, touchpad, and gesture settings for Hyprland.
-- =============================================================================

hl.config({
    input = {
        -- =====================================================================
        -- KEYBOARD
        -- =====================================================================
        kb_layout  = "us",              -- Keyboard layout (use multiple for multi-layout)
        kb_variant = "",                -- Layout variant (e.g., "dvorak", "colemak")
        kb_model   = "",                -- Keyboard model (e.g., "pc105", "thinkpad")
        kb_options = "",                -- XKB options (e.g., "grp:alt_shift_toggle")
        kb_rules   = "",                -- XKB rules file
        numlock_by_default = true,      -- Enable numlock on boot
        repeat_rate  = 35,             -- Key repeat rate (chars/sec)
        repeat_delay = 200,            -- Delay before repeat starts (ms)

        -- =====================================================================
        -- MOUSE
        -- =====================================================================
        follow_mouse = 2,               -- 0=no follow, 1=follow on move, 2=follow on click
        mouse_refocus = false,          -- Don't autofocus window on mouse move
        float_switch_override_focus = 1,
        sensitivity = 0.0,              -- Mouse sensitivity (-1.0 to 1.0, 0 = neutral)
        accel_profile = "flat",         -- "flat" = no acceleration, "adaptive" = standard

        -- =====================================================================
        -- TOUCHPAD
        -- =====================================================================
        touchpad = {
            clickfinger_behavior   = 1,     -- 1 = two-finger right-click
            disable_while_typing   = true,  -- Prevent accidental palm taps
            drag_lock              = true,  -- Keep drag active without holding
            natural_scroll         = true,  -- Inverted scroll (content follows finger)
            scroll_factor          = 1.0,   -- Scroll speed multiplier
            tap_to_click           = true,  -- Tap to click
            middle_button_emulation = false,-- Three-finger tap for middle click
        },
    },
})

-- =============================================================================
-- GESTURES
-- =============================================================================
-- Touchpad gestures (swipe) that trigger workspace or layout changes.

-- Three-finger horizontal swipe = workspace navigation
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",           -- Swipe left/right to change workspaces
})

-- Three-finger vertical swipe = fullscreen toggle
hl.gesture({
    fingers = 3,
    direction = "vertical",
    action = "fullscreen",          -- Swipe up/down to toggle fullscreen
})

-- Four-finger horizontal swipe = workspace navigation (optional)
-- hl.gesture({
--     fingers = 4,
--     direction = "horizontal",
--     action = "workspace",
-- })

-- =============================================================================
-- ADDITIONAL KEYBOARD LAYOUT EXAMPLES
-- =============================================================================
-- United States (Dvorak):      kb_layout = "us", kb_variant = "dvorak"
-- United Kingdom:              kb_layout = "gb"
-- Canada (French):             kb_layout = "ca"
-- Germany:                     kb_layout = "de"
-- France (Azerty):             kb_layout = "fr"
-- Japan:                       kb_layout = "jp"
-- Brazil (ABNT2):              kb_layout = "br", kb_variant = "abnt2"
-- Russian:                     kb_layout = "ru"
-- Arabic:                      kb_layout = "ara"
--
-- Multi-layout:                kb_layout = "us,ru", kb_options = "grp:alt_shift_toggle"
-- Multiple variants:           kb_layout = "us,us", kb_variant = "dvorak,", kb_options = "grp:caps_toggle"
-- Colemak:                     kb_layout = "us", kb_variant = "colemak"
-- Workman:                     kb_layout = "us", kb_variant = "workman"
-- Programmer Dvorak:           kb_layout = "us", kb_variant = "dvp"

-- =============================================================================
-- REPEAT RATE REFERENCE
-- =============================================================================
-- repeat_rate / repeat_delay presets:
--   Slow:       15 / 400
--   Default:    25 / 300
--   Fast:       35 / 200
--   Ultra-fast: 50 / 150
--   Gaming:     60 / 100
