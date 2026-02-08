# WezTerm Configuration
# GPU-accelerated terminal emulator

local wezterm = require 'wezterm'
local config = {}

-- Font configuration
config.font = wezterm.font_with_fallback({
  "Caskaydiacove Nerd Font Mono",
  "JetBrains Mono",
  "Fira Code",
  "Cascadia Code",
})
config.font_size = 11.0
config.line_height = 1.2

-- Window configuration
config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Enable scroll bar
config.enable_scroll_bar = true
config.scrollback_lines = 10000

-- Gruvbox Dark Hard color scheme
config.color_scheme = "Gruvbox Dark (Gogh)"

-- Alternatively, define colors manually
config.colors = {
  foreground = "#ebdbb2",
  background = "#1d2021",
  cursor_bg = "#ebdbb2",
  cursor_fg = "#1d2021",
  cursor_border = "#ebdbb2",
  selection_fg = "#1d2021",
  selection_bg = "#ebdbb2",
  
  ansi = {
    "#1d2021",
    "#cc241d",
    "#98971a",
    "#d79921",
    "#458588",
    "#b16286",
    "#689d6a",
    "#a89984",
  },
  brights = {
    "#928374",
    "#fb4934",
    "#b8bb26",
    "#fabd2f",
    "#83a598",
    "#d3869b",
    "#8ec07c",
    "#ebdbb2",
  },
}

-- Cursor configuration
config.default_cursor_style = "Block"
config.cursor_blink_rate = 500

-- Key bindings
config.keys = {
  -- Split panes
  {key="d", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
  {key="e", mods="CTRL|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
  -- Close pane
  {key="w", mods="CTRL|SHIFT", action=wezterm.action.CloseCurrentPane{confirm=true}},
  -- New tab
  {key="t", mods="CTRL|SHIFT", action=wezterm.action.SpawnTab("CurrentPaneDomain")},
  -- Close tab
  {key="q", mods="CTRL|SHIFT", action=wezterm.action.CloseCurrentTab{confirm=true}},
  -- Navigate tabs
  {key="Tab", mods="CTRL", action=wezterm.action.ActivateTabRelative(1)},
  {key="Tab", mods="CTRL|SHIFT", action=wezterm.action.ActivateTabRelative(-1)},
  -- Copy/Paste
  {key="c", mods="CTRL|SHIFT", action=wezterm.action.CopyTo("Clipboard")},
  {key="v", mods="CTRL|SHIFT", action=wezterm.action.PasteFrom("Clipboard")},
  -- Search
  {key="f", mods="CTRL|SHIFT", action=wezterm.action.Search("CurrentSelectionOrEmptyString")},
  -- Font size
  {key="+", mods="CTRL|SHIFT", action=wezterm.action.IncreaseFontSize},
  {key="-", mods="CTRL|SHIFT", action=wezterm.action.DecreaseFontSize},
  {key="0", mods="CTRL|SHIFT", action=wezterm.action.ResetFontSize},
  -- Reload config
  {key="r", mods="CTRL|SHIFT", action=wezterm.action.ReloadConfiguration},
}

-- Tab bar configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false

-- Scroll configuration
config.scrollback_lines = 10000

-- Bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 150,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 150,
}

-- URL detection
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Mouse configuration
config.hide_mouse_cursor_when_typing = true

return config