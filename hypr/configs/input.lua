-- Input configuration
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 2,
        mouse_refocus = false,
        touchpad = {
            clickfinger_behavior = 1,
            natural_scroll = true,
            disable_while_typing = true,
            tap_to_click = true,
            drag_lock = true,
            scroll_factor = 1.0,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
