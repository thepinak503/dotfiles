-- =============================================================================
-- THEME COLORS — NORD PALETTE (DEFAULT DARK)
-- =============================================================================
-- This file defines the complete Nord color palette used across all Hyprland
-- configs. Theme variables (theme.*) are global and accessible from any lua
-- config file that's loaded after this one.
--
-- The theme.sh script switches between this dark theme and the light theme
-- by replacing this file with the appropriate variant.
-- =============================================================================

-- =============================================================================
-- DARK THEME (Nord)
-- =============================================================================
-- Classic Nord color scheme for dark environments.
-- Backgrounds are cool dark blues, accents are teal/cyan.

theme = {
    -- Background colors (dark to lighter)
    bg        = "rgb(2e3440)",  -- Base dark background (nord0)
    bg_alt    = "rgb(3b4252)",  -- Slightly lighter (nord1)
    bg_surface= "rgb(434c5e)",  -- Surface/card backgrounds (nord2)
    border    = "rgb(4c566a)",  -- Border color (nord3)

    -- Foreground colors
    fg        = "rgb(d8dee9)",  -- Primary text (nord4)
    fg_bright = "rgb(eceff4)",  -- Bright/highlighted text (nord6)
    fg_dim    = "rgb(81a1c1)",  -- Dim/subtle text

    -- Accent colors (teal/cyan palette)
    accent    = "rgb(88c0d0)",  -- Primary accent (nord8)
    accent2   = "rgb(8fbcbb)",  -- Secondary accent (nord7)
    accent3   = "rgb(81a1c1)",  -- Tertiary accent (nord10)
    accent4   = "rgb(5e81ac)",  -- Dark accent (nord9)

    -- Semantic colors
    red       = "rgb(bf616a)",  -- Error/danger (nord11)
    orange    = "rgb(d08770)",  -- Warning (nord12)
    yellow    = "rgb(ebcb8b)",  -- Caution/notice (nord13)
    green     = "rgb(a3be8c)",  -- Success (nord14)
    purple    = "rgb(b48ead)",  -- Info/misc (nord15)

    -- Additional semantic colors
    error     = "rgb(bf616a)",
    success   = "rgb(a3be8c)",
    warning   = "rgb(d08770)",
    info      = "rgb(88c0d0)",
}

-- =============================================================================
-- RGB VALUE VARIANTS (for gradient and opacity calculations)
-- =============================================================================
-- Same colors as above but in comma-separated RGB format for programmatic use
-- (e.g., constructing rgba() strings with custom alpha values).

theme_rgb = {
    bg        = "46,52,64",
    bg_alt    = "59,66,82",
    bg_surface= "67,76,94",
    border    = "76,86,106",
    fg        = "216,222,233",
    fg_bright = "236,239,244",
    fg_dim    = "129,161,193",
    accent    = "136,192,208",
    accent2   = "143,188,187",
    accent3   = "129,161,193",
    accent4   = "94,129,172",
    red       = "191,97,106",
    orange    = "208,135,112",
    yellow    = "235,203,139",
    green     = "163,190,140",
    purple    = "180,142,173",
    error     = "191,97,106",
    success   = "163,190,140",
    warning   = "208,135,112",
    info      = "136,192,208",
}

-- =============================================================================
-- LIGHT THEME (Nord Light) — COMMENTED BY DEFAULT
-- =============================================================================
-- Uncomment the block below and comment out the dark theme above
-- to use the light theme variant. Then run: hyprctl reload
--
-- theme = {
--     -- Background colors (light to darker)
--     bg        = "rgb(eceff4)",  -- Base light background (nord6)
--     bg_alt    = "rgb(e5e9f0)",  -- Slightly darker (nord5)
--     bg_surface= "rgb(d8dee9)",  -- Surface/card backgrounds (nord4)
--     border    = "rgb(81a1c1)",  -- Border color (nord10)
--
--     -- Foreground colors
--     fg        = "rgb(2e3440)",  -- Primary text (nord0)
--     fg_bright = "rgb(3b4252)",  -- Bright text (nord1)
--     fg_dim    = "rgb(4c566a)",  -- Dim text (nord3)
--
--     -- Accent colors
--     accent    = "rgb(5e81ac)",  -- Primary accent (nord9)
--     accent2   = "rgb(81a1c1)",  -- Secondary accent (nord10)
--     accent3   = "rgb(88c0d0)",  -- Tertiary accent (nord8)
--     accent4   = "rgb(8fbcbb)",  -- Dark accent (nord7)
--
--     -- Semantic colors
--     red       = "rgb(bf616a)",
--     orange    = "rgb(d08770)",
--     yellow    = "rgb(ebcb8b)",
--     green     = "rgb(a3be8c)",
--     purple    = "rgb(b48ead)",
--     error     = "rgb(bf616a)",
--     success   = "rgb(a3be8c)",
--     warning   = "rgb(d08770)",
--     info      = "rgb(5e81ac)",
-- }
--
-- theme_rgb = {
--     bg        = "236,239,244",
--     bg_alt    = "229,233,240",
--     bg_surface= "216,222,233",
--     border    = "129,161,193",
--     fg        = "46,52,64",
--     fg_bright = "59,66,82",
--     fg_dim    = "76,86,106",
--     accent    = "94,129,172",
--     accent2   = "129,161,193",
--     accent3   = "136,192,208",
--     accent4   = "143,188,187",
--     red       = "191,97,106",
--     orange    = "208,135,112",
--     yellow    = "235,203,139",
--     green     = "163,190,140",
--     purple    = "180,142,173",
--     error     = "191,97,106",
--     success   = "163,190,140",
--     warning   = "208,135,112",
--     info      = "94,129,172",
-- }
--
-- =============================================================================
-- USAGE
-- =============================================================================
-- In any Lua config file, reference theme colors as:
--   theme.accent      → "rgb(88c0d0)"
--   theme.bg          → "rgb(2e3440)"
--   theme.fg          → "rgb(d8dee9)"
--
-- For gradients, pass an array of colors:
--   { colors = {theme.accent, theme.accent3}, angle = 45 }
--
-- For rgba() with custom alpha:
--   "rgba(" .. theme_rgb.accent .. ",0.8)" → "rgba(136,192,208,0.8)"
--
-- For references:
--   https://www.nordtheme.com/docs/colors-and-palettes
-- =============================================================================
