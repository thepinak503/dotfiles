-- =============================================================================
-- WORKSPACE, LAYOUT & MISC CONFIGURATION
-- =============================================================================
-- Controls Dwindle/Master layout behavior, window swallowing, debug options,
-- and miscellaneous Hyprland settings.
-- =============================================================================

hl.config({
    -- =========================================================================
    -- DWINDLE LAYOUT
    -- =========================================================================
    dwindle = {
        preserve_split = true,         -- Keep split direction when resizing
        default_split_ratio = 1,       -- Split ratio (1 = 50/50, >1 = larger master)
        smart_split = true,            -- Smart split direction based on cursor position
        smart_resizing = true,         -- Smart resize direction
        permanent_direction_override = true, -- Remember split direction across window changes
        use_active_for_splits = true,  -- Use active window for split direction
        split_width_multiplier = 1.0,  -- Multiplier for split width calculation
    },

    -- =========================================================================
    -- MASTER LAYOUT
    -- =========================================================================
    master = {
        new_status = "slave",          -- Position of new windows: "master" or "slave"
        mfact = 0.55,                  -- Master-to-slave area ratio (0.5 = equal)
        orientation = "center",        -- Master position: "left", "right", "top", "bottom", "center"
        slave_count_for_center_master = 0, -- Slaves needed before centering master
        new_on_top = true,            -- New windows appear on top of the stack
        drop_at_cursor = true,        -- New windows appear at cursor position
    },

    -- =========================================================================
    -- KEY BINDINGS
    -- =========================================================================
    binds = {
        workspace_back_and_forth = true,   -- Toggle between last two workspaces
        allow_workspace_cycles = true,     -- Allow cycling past workspace 9 to 1
        movefocus_cycles_fullscreen = true,-- Allow focus cycling through fullscreen windows
        scroll_event_delay = 250,          -- Scroll event debounce (ms)
    },

    -- =========================================================================
    -- MISC SETTINGS
    -- =========================================================================
    misc = {
        force_default_wallpaper = 0,           -- 0=use hyprpaper, 1=default, 2=random default
        disable_hyprland_logo = true,          -- Hide the Hyprland logo on empty workspace
        disable_splash_rendering = true,       -- Hide splash text
        animate_mouse_windowdragging = false,  -- Smooth animation when dragging windows
        enable_swallow = true,                 -- Terminal window swallowing (e.g., kitty running vim)
        swallow_regex = "^(kitty)$",           -- Which terminal emulators can swallow
        swallow_exception_regex = "",          -- Exception to swallow
        on_focus_under_fullscreen = 2,         -- 0=ignore, 1=fullscreen, 2=fullscreen+focus
        initial_workspace_tracking = 2,        -- 0=off, 1=follow mouse, 2=track all windows
        mouse_move_enables_dpms = true,        -- Wake up display from DPMS on mouse move
        key_press_enables_dpms = false,        -- Wake up display from DPMS on key press
        disable_autoreload = true,             -- Disable automatic config reload
        vrr = 1,                               -- Enable VRR (1=on, 0=off, 2=fullscreen)
        layers_hog_keyboard_focus = true,      -- Layer surfaces get keyboard focus
        background_color = "rgb(2e3440)",      -- Background color
        focus_on_activate = true,              -- Focus apps that request it
        mouse_move_focuses_monitor = true,     -- Move focus when mouse changes monitor
    },

    -- =========================================================================
    -- DEBUG & PERFORMANCE
    -- =========================================================================
    debug = {
        disable_logs = false,          -- Enable logging
        disable_time = false,          -- Disable time logging
        damage_blink = false,          -- Flash damaged regions (debug)
        manual_crash = false,          -- Manual crash for testing
        suppress_errors = false,       -- Show all errors
        vfr = true,                    -- Variable frame rate
        damage_tracking = 2,           -- 0=off, 1=partial, 2=full
        overlay = false,               -- Show overlay for debugging
    },

    -- =========================================================================
    -- XWAYLAND
    -- =========================================================================
    xwayland = {
        force_zero_scaling = true,             -- Disable XWayland scaling (prevents blurry X11 apps)
        use_nearest_neighbor = false,           -- Use nearest neighbor for XWayland scaling
    },

    -- =========================================================================
    -- EXPERIMENTAL & TEARING
    -- =========================================================================
    general = {
        allow_tearing = true,                  -- Allow tearing for latency-sensitive apps (games)
    },
    
    -- =========================================================================
    -- WORKSPACE RULES (SMART GAPS & BINDINGS)
    -- =========================================================================
    -- Smart gaps (no gaps when only one window is open on a workspace)
    -- (Requires a workspace rule for each workspace or wildcard)
})

-- Default workspaces for certain apps
hl.window_rule({ match = { class = "^firefox$" }, workspace = "2" })
hl.window_rule({ match = { class = "^google-chrome.*" }, workspace = "2" })
hl.window_rule({ match = { class = "^discord$" }, workspace = "7" })
hl.window_rule({ match = { class = "^WebCord$" }, workspace = "7" })
hl.window_rule({ match = { class = "^telegram.*" }, workspace = "7" })
hl.window_rule({ match = { class = "^Spotify$" }, workspace = "8" })

-- Smart gaps removed due to wrapper incompatibility

-- =============================================================================
-- LAYOUT REFERENCE
-- =============================================================================
-- Dwindle Layout:
--   - Windows are split in a binary tree (like i3/bspwm)
--   - Best for keyboard-driven workflows
--   - Commands: togglesplit, splitratio, pseudo
--
-- Master Layout:
--   - One master area + stack of slaves
--   - Best for focused work with reference windows
--   - Commands: layoutmsg mfact, layoutmsg master, layoutmsg swapwithmaster
--
-- Toggle between layouts: SUPER + CTRL + L
-- =============================================================================

-- =============================================================================
-- DWINDLE SPLIT RATIO PRESETS
-- =============================================================================
-- default_split_ratio values:
--   0.5 = 50/50 (even split)
--   0.6 = 60/40
--   0.7 = 70/30 (master gets more space)
--   1.0 = 100/0 (non-dwindle behavior)
-- =============================================================================

-- =============================================================================
-- MASTER FACTOR PRESETS
-- =============================================================================
-- mfact values:
--   0.50 = 50/50 (equal)
--   0.55 = 55/45 (master slightly larger)
--   0.60 = 60/40
--   0.65 = 65/35
--   0.70 = 70/30 (master significantly larger)
