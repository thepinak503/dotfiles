-- =============================================================================
-- PER-DEVICE INPUT CONFIGURATION
-- =============================================================================
-- Configure input settings for specific devices (touchpads, keyboards, mice).
-- Use 'hyprctl devices' to list all connected input devices with their names.
--
-- NOTE: Per-device touchpad/keyboard/mouse settings via hl.device() are not
-- supported in Hyprland v0.55+. Use global input settings in input.lua instead,
-- or set per-device via hyprctl keyword at runtime.
-- =============================================================================

-- =============================================================================
-- TOUCHPADS
-- =============================================================================

-- Synaptics PS/2 Touchpad (common on laptops)
-- hl.device({ name = "synps/2-synaptics-touchpad", enabled = true })

-- Syna3067 Touchpad (Lenovo, Dell, other modern laptops)
-- hl.device({ name = "syna3067:00-06cb:8265-touchpad", enabled = true })

-- ELAN Touchpad
-- hl.device({ name = "elan0001:00-04f3:3190-touchpad", enabled = true })

-- =============================================================================
-- MICE
-- =============================================================================

-- Logitech MX Master 3 / Anywhere
-- hl.device({ name = "logitech-mx-master-3" })

-- =============================================================================
-- KEYBOARDS
-- =============================================================================

-- Apple Magic Keyboard
-- hl.device({ name = "apple-magic-keyboard" })

-- Built-in laptop keyboard (generic)
-- hl.device({ name = "at-translated-set-2-keyboard" })

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
