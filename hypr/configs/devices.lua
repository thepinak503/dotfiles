-- =============================================================================
-- PER-DEVICE INPUT CONFIGURATION
-- =============================================================================
-- Configure input settings for specific devices (touchpads, keyboards, mice).
-- Use 'hyprctl devices' to list all connected input devices with their names.
-- =============================================================================

-- =============================================================================
-- TOUCHPADS
-- =============================================================================

-- Synaptics PS/2 Touchpad (common on laptops)
hl.device({
    name    = "synps/2-synaptics-touchpad",
    enabled = true,
    touchpad = {
        clickfinger_behavior   = 1,    -- 1 = two-finger right-click, 2 = three-finger middle-click
        disable_while_typing   = true, -- Prevent palm taps while typing
        drag_lock              = true, -- Tap-and-hold for drag without holding
        natural_scroll         = true, -- Two-finger scroll follows content direction
        scroll_factor          = 1.0,  -- Scroll speed multiplier
        tap_to_click           = true, -- Tap to click (instead of pressing)
        middle_button_emulation = false, -- Three-finger tap for middle click
        clickfinger_behavior = 1,      -- Finger count determines click button
    },
})

-- Syna3067 Touchpad (Lenovo, Dell, other modern laptops)
hl.device({
    name    = "syna3067:00-06cb:8265-touchpad",
    enabled = true,
    touchpad = {
        clickfinger_behavior   = 1,
        disable_while_typing   = true,
        drag_lock              = true,
        natural_scroll         = true,
        scroll_factor          = 1.0,
        tap_to_click           = true,
        middle_button_emulation = false,
    },
})

-- ELAN Touchpad
-- hl.device({
--     name    = "elan0001:00-04f3:3190-touchpad",
--     enabled = true,
--     touchpad = {
--         clickfinger_behavior = 1,
--         disable_while_typing = true,
--         natural_scroll       = true,
--         scroll_factor        = 1.0,
--         tap_to_click         = true,
--     },
-- })

-- =============================================================================
-- MICE
-- =============================================================================

-- Logitech MX Master 3 / Anywhere
-- hl.device({
--     name = "logitech-mx-master-3",
--     mouse = {
--         accel_profile = "flat",     -- Flat acceleration (no accel)
--         sensitivity   = 0.0,        -- Sensitivity (-1.0 to 1.0)
--         natural_scroll = false,     -- Traditional scroll direction for mice
--         scroll_factor  = 1.0,       -- Scroll speed
--     },
-- })

-- =============================================================================
-- KEYBOARDS
-- =============================================================================

-- Apple Magic Keyboard
-- hl.device({
--     name = "apple-magic-keyboard",
--     keyboard = {
--         repeat_rate    = 30,   -- Characters per second (hold)
--         repeat_delay   = 250,  -- Milliseconds before repeat starts
--         numlock_by_default = true,
--         capslock_as_ctrl    = false,
--     },
-- })

-- Built-in laptop keyboard (generic)
hl.device({
    name = "at-translated-set-2-keyboard",
    keyboard = {
        repeat_rate    = 35,    -- Fast repeat rate
        repeat_delay   = 200,   -- Short delay before repeat begins
        numlock_by_default = true,
        capslock_as_ctrl    = false,
    },
})

-- =============================================================================
-- GLOBAL INPUT SETTINGS (fallback for all devices)
-- =============================================================================
-- These apply to devices not explicitly configured above.

-- hl.config({
--     input = {
--         kb_layout  = "us",
--         kb_variant = "",
--         kb_model   = "",
--         kb_options = "grp:alt_shift_toggle",  -- Toggle layouts with Alt+Shift
--         kb_rules   = "",
--         repeat_rate  = 35,
--         repeat_delay = 200,
--         follow_mouse = 2,       -- 1 = focus follows mouse, 2 = focus on click
--         mouse_refocus = false,  -- Don't refocus on mouse move
--         float_switch_override_focus = 1,
--         sensitivity = 0.0,      -- Mouse sensitivity (-1.0 to 1.0, 0 = neutral)
--         accel_profile = "flat", -- No mouse acceleration
--     },
-- })

-- =============================================================================
-- TROUBLESHOOTING
-- =============================================================================
-- To find your device names:
--   hyprctl devices
--
-- To test a setting temporarily:
--   hyprctl keyword device:[name]:enabled true
--   hyprctl keyword device:[name]:touchpad:natural_scroll true
--
-- To disable a device:
--   Set enabled = false in the hl.device() block
