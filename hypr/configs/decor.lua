-- Colors, borders, decoration, shadow and blur configuration
hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = { colors = {theme.accent, theme.accent3, theme.accent2}, angle = 45 },
            inactive_border = theme.bg_alt,
        },
        layout = "dwindle",
        resize_corner = 2,
    },
    cursor = {
        inactive_timeout = 3,
    },
    decoration = {
        rounding           = 10,
        active_opacity     = 0.95,
        inactive_opacity   = 0.85,
        fullscreen_opacity = 1.0,
        shadow = {
            enabled        = true,
            range          = 16,
            render_power   = 4,
            color          = "rgba(0,0,0,0.55)",
            color_inactive = "rgba(0,0,0,0.35)",
            offset         = { 3, 5 },
            scale          = 0.97,
        },
        blur = {
            enabled            = true,
            size               = 10,
            passes             = 3,
            ignore_opacity     = false,
            xray               = false,
            noise              = 0.01,
            contrast           = 0.8,
            brightness         = 1.0,
            popups             = true,
            popups_ignorealpha = 0.6,
        },
    },
})
