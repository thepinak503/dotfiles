-- Bezier curves and animations configuration
hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("overshot",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1}  } })
hl.curve("smoothOut",  { type = "bezier", points = { {0.36, 0},   {0.66, -0.56} } })
hl.curve("smoothIn",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1}   } })
hl.curve("smoothWS",   { type = "bezier", points = { {0.25, 0.1}, {0.25, 1}   } })
hl.curve("fluide",     { type = "bezier", points = { {0.3, 0.0},  {0.3, 1.0}  } })

hl.animation({ leaf = "windows",          enabled = true, speed = 5,  bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 5,  bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 5,  bezier = "overshot", style = "slide" })
hl.animation({ leaf = "border",           enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 20, bezier = "default", style = "once" })
hl.animation({ leaf = "fade",             enabled = true, speed = 5,  bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim",          enabled = true, speed = 5,  bezier = "smoothIn" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 6,  bezier = "smoothWS", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6,  bezier = "smoothWS", style = "slide" })
